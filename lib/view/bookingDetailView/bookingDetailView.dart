import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rovertaxi/component/acceptRejectView/acceptRejectView.dart';
import 'package:rovertaxi/component/popupViewWithTextField/PopupViewWithTextField.dart';
import 'package:rovertaxi/model/bookingModel/bookingModel.dart';
import 'package:rovertaxi/view_model/booking_view_model/BookingViewModel.dart';

import '../../Utilities/Constant.dart';
import '../../Utilities/googleService.dart';
import '../../Utilities/res/Assets.dart';
import '../../Utilities/res/color.dart';
import '../../Utilities/utils.dart';
import '../../model/polyline_response.dart';
import '../home/homeView.dart';

class BookDetailView extends StatefulWidget {
  final RideData? rideData;
  const BookDetailView({super.key, this.rideData});

  @override
  State<BookDetailView> createState() => _BookDetailViewState();
}

class _BookDetailViewState extends State<BookDetailView> {
  LatLng? currentLatLng;
  Set<Marker> markersList = {};
  RideResponse? rideResponse;
  late BitmapDescriptor customIcon;
  static const CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962), zoom: 14);
  late GoogleMapController googleMapController;
  BookingViewModel bookingViewModel = BookingViewModel();
  bool isCancelAlertShown = false;
  String acceptBtnTitle = 'ACCEPT';
  String rejectBtnTitle = 'REJECT';
  Set<Polyline> polylinePoints = {};
  PolyLineData? polyLineData;
  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );

  @override
  void initState() {
    super.initState();
    initialSetup();
  }

  initialSetup() async {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(5, 5)), Assets.assetsCarIcon)
        .then((d) {
      customIcon = d;
    });

    if (widget.rideData?.rideId != null) {
      getDriverRideStatusApi(widget.rideData!.rideId as int);

      if (polylinePoints.isEmpty) {
        print('MMMMMMMMMMMMMMMM');
        var origin = LatLng(double.parse(widget.rideData!.pickupLat ?? '0.0'),
            double.parse(widget.rideData!.pickupLng ?? '0.0'));
        var destination = LatLng(
            double.parse(widget.rideData!.dropLat ?? '0.0'),
            double.parse(widget.rideData!.dropLng ?? '0.0'));

        await GoogleService.instance
            .drawPolyline(origin, destination)
            .then((value) => setState(() {
                  polyLineData = value;
                  polylinePoints = value.polylinePoints;
                  googleMapController.animateCamera(
                      CameraUpdate.newCameraPosition(
                          CameraPosition(target: origin, zoom: 10)));
                }));
        setDriversOnMap(origin, destination, origin);
      }
    }
    updateDriverPosition();
  }

  setDriversOnMap(LatLng origin, LatLng destination, LatLng driverPosition) {
    markersList.clear();
    markersList.add(Marker(markerId: const MarkerId("0"), position: origin));
    markersList
        .add(Marker(markerId: const MarkerId("1"), position: destination));
    setState(() {
      markersList.add(Marker(
          markerId: const MarkerId('2'),
          position: LatLng(driverPosition.latitude, driverPosition.longitude),
          icon: customIcon));
    });
  }

  ///***************** Update Driver Position ********************
  updateDriverPosition() {
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position? position) {
      setState(() {
        currentLatLng = LatLng(position!.latitude, position.longitude);
        if (currentLatLng != null) {
          print('MARKER CALLEEDD');
          setDriversOnMap(
              LatLng(double.parse(rideResponse?.rideData?.pickupLat ?? '0.0'),
                  double.parse(rideResponse?.rideData?.pickupLng ?? '0.0')),
              LatLng(double.parse(rideResponse?.rideData?.dropLat ?? '0.0'),
                  double.parse(rideResponse?.rideData?.dropLng ?? '0.0')),
              currentLatLng!);
        }
      });
    });
  }

  ///***************** Handle Ride Status ***********************
  handleRideStatus() {
    if (rideResponse?.rideData?.rideStatus == Constant.TRIP_STATUS_CANCELED) {
      if (widget.rideData?.cancelType == Constant.USER) {
        if (!isCancelAlertShown) {
          isCancelAlertShown = true;
          // Navigator.pop(context);

          Utils.showAlert(context,
              'Your ride cancelled By User - ${widget.rideData?.cancelReason}');
        }
      }
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const HomeView(isRejected: true)),
      );
    } else if (rideResponse?.rideData?.rideStatus == Constant.TRIP_STATUS_END) {
      // Future.delayed(const Duration(seconds: 1), () async {
      //   Navigator.pushReplacementNamed(context, RoutesName.homeView);
      // });
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const HomeView(isRejected: true)),
      );
      Utils.showAlert(context, 'Ride has been completed Successfully');
    } else {
      handleBtnLablStatus();
      callAgainRideStatusApi();
    }
  }

  ///***************** Call Again GetAllNotifications API ***********************
  callAgainRideStatusApi() {
    Future.delayed(const Duration(seconds: 5), () {
      if ((rideResponse?.rideData?.rideId ?? 0) != 0) {
        print('CALLED AGAIN RIDE STATUS');
        getDriverRideStatusApi(rideResponse?.rideData?.rideId ?? 0);
      }
    });
  }

  ///***************** GetRideStatus API ***********************
  getDriverRideStatusApi(int rideId) {
    Map param = {'ride_id': '$rideId'};
    bookingViewModel.getRideStatus(param, context).then((value) => {
          setState(() {
            rideResponse = value;
            if (rideResponse?.rideData?.rideStatus !=
                Constant.TRIP_STATUS_END) {
              handleRideStatus();
            }
          })
        });
  }

  ///***************** ACCEPT\REJECT RIDE API ***********************
  acceptRejectRideApi(int rideId, String rideStatus) {
    Map param = {
      'ride_id': "$rideId",
      'ride_status': rideStatus,
      'deviceToken': 'dummy'
    };
    print('RIDE ACCEPT PARAM: $param');
    bookingViewModel.acceptRejectRide(param, context).then((value) => {
          setState(() {
            print('?????????????????????${value?.rideData?.rideStatus}');
            rideResponse = value;
            if (value?.rideData?.rideStatus == Constant.TRIP_STATUS_CONFIRMED) {
              acceptBtnTitle = 'GOING TO PICKUP USER';
              rejectBtnTitle = 'CANCEL';
            }
          })
        });
  }

  ///***************** UPDATE RIDE API ***********************///
  updateRideStatus(dynamic params) {
    bookingViewModel.updateRideAPI(params, context).then((value) => {
          setState(() {
            rideResponse = value;
            handleBtnLablStatus();
            handleRideStatus();
          })
        });
  }

  ///***************** CANCEL RIDE CALL ***********************///
  callCancelRide(String cancelReason) {
    Map param = {
      'ride_id': '${rideResponse?.rideData?.rideId ?? 0}',
      'ride_status': Constant.TRIP_STATUS_CANCELED,
      'cancel': '1',
      'cancel_reason': cancelReason,
      'cancel_type': Constant.DRIVER
    };
    updateRideStatus(param);
  }

  handleBtnLablStatus() {
    setState(() {
      if (rideResponse?.rideData?.rideStatus ==
          Constant.TRIP_STATUS_CONFIRMED) {
        acceptBtnTitle = 'GOING TO PICKUP USER';
        rejectBtnTitle = 'CANCEL';
      } else if (rideResponse?.rideData?.rideStatus ==
          Constant.TRIP_STATUS_ARRIVING) {
        acceptBtnTitle = 'REACHED';
        rejectBtnTitle = 'CANCEL';
      } else if (rideResponse?.rideData?.rideStatus ==
          Constant.TRIP_STATUS_REACHED) {
        acceptBtnTitle = 'START TRIP';
        rejectBtnTitle = 'CANCEL';
      } else if (rideResponse?.rideData?.rideStatus ==
          Constant.TRIP_STATUS_BEGIN) {
        ///REJECT NEED TO HIDE
        rejectBtnTitle = '';
        acceptBtnTitle = 'END TRIP';
      }
    });
  }

  showAlertDialog(String msg) async {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Rover Driver'),
        content: Text(msg),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              handleBtnActionStatus();
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  handleBtnActionStatus() async {
    if (rideResponse?.rideData?.rideStatus == Constant.TRIP_STATUS_CONFIRMED) {
      Map param = {};
      param['ride_id'] = '${rideResponse?.rideData?.rideId ?? 0}';
      param['ride_status'] = Constant.TRIP_STATUS_ARRIVING;
      updateRideStatus(param);
    } else if (rideResponse?.rideData?.rideStatus ==
        Constant.TRIP_STATUS_ARRIVING) {
      Map param = {};
      param['ride_id'] = '${rideResponse?.rideData?.rideId ?? 0}';
      param['ride_status'] = Constant.TRIP_STATUS_REACHED;
      updateRideStatus(param);
    } else if (rideResponse?.rideData?.rideStatus ==
        Constant.TRIP_STATUS_REACHED) {
      Future.delayed(const Duration(seconds: 1), () {
        showDataAlert();
      });
    } else if (rideResponse?.rideData?.rideStatus ==
        Constant.TRIP_STATUS_BEGIN) {
      Map param = {};
      param['ride_id'] = '${rideResponse?.rideData?.rideId ?? 0}';
      param['ride_status'] = Constant.TRIP_STATUS_END;
      updateRideStatus(param);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackgroundColor,
        title: const Text('Ride Detail'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: GoogleMap(
              mapType: MapType.normal,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              initialCameraPosition: initialCameraPosition,
              markers: markersList,
              polylines: polylinePoints,
              onMapCreated: (GoogleMapController controller) {
                googleMapController = controller;
              },
            ),
          ),
          Expanded(
              flex: 6,
              child: AcceptRejectView(
                rideResponse: rideResponse,
                acceptTitleStr: acceptBtnTitle,
                rejectTitleStr: rejectBtnTitle,
                onTapAcceptReject: ((index) => {
                      if (index == 0)
                        {
                          if (rejectBtnTitle == Constant.DRIVER_REJECT_BTN)
                            {
                              // Navigator.pushNamed(context, RoutesName.homeView)
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const HomeView(isRejected: true)),
                              ),
                            }
                          else
                            {
                              if (rideResponse?.rideData?.rideStatus ==
                                      Constant.TRIP_STATUS_CONFIRMED ||
                                  rideResponse?.rideData?.rideStatus ==
                                      Constant.TRIP_STATUS_ARRIVING ||
                                  rideResponse?.rideData?.rideStatus ==
                                      Constant.TRIP_STATUS_REACHED)
                                {
                                  Utils.showAlertDialogWithActions(
                                      context,
                                      'Are you sure, you want to cancel this ride?',
                                      (() => {
                                            Future.delayed(
                                                const Duration(seconds: 1), () {
                                              callCancelReasonAlert();
                                            })
                                            // callCancelRide()
                                          }))
                                }
                            }
                        }
                      else if (index == 1)
                        {
                          if (rideResponse?.rideData?.rideStatus ==
                              Constant.TRIP_STATUS_NEW)
                            {
                              acceptRejectRideApi(
                                  rideResponse?.rideData?.rideId ?? 0,
                                  Constant.DRIVER_ACCEPT)
                            }
                          else if (rideResponse?.rideData?.rideStatus ==
                              Constant.TRIP_STATUS_CONFIRMED)
                            {showAlertDialog('Going to pickup User?')}
                          else if (rideResponse?.rideData?.rideStatus ==
                              Constant.TRIP_STATUS_ARRIVING)
                            {
                              showAlertDialog(
                                  'Have you reached the User location?')
                            }
                          else if (rideResponse?.rideData?.rideStatus ==
                              Constant.TRIP_STATUS_REACHED)
                            {showAlertDialog('Are you starting this trip?')}
                          else if (rideResponse?.rideData?.rideStatus ==
                              Constant.TRIP_STATUS_BEGIN)
                            {showAlertDialog('Do you want to end this trip?')}
                        }
                    }),
              ))
        ],
      ),
    );
  }

  callCancelReasonAlert() {
    showDialog(
        context: context,
        builder: (context) {
          return PopupViewWithTextField(
            onTapSubmit: ((value) => {callCancelRide(value)}),
          );
        });
  }

  showDataAlert() {
    TextEditingController otpController = TextEditingController();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  8.0,
                ),
              ),
            ),
            contentPadding: const EdgeInsets.only(
              top: 10.0,
            ),
            title: const Center(
              child: Text(
                "Please Enter Ride OTP",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            content: SizedBox(
              height: 170,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      maxLength: 6,
                      controller: otpController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Otp here',
                          labelText: 'Enter Otp here'),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 150,
                        height: 60,
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: AppColors.primaryBackgroundColor,
                            // fixedSize: Size(250, 50),
                          ),
                          child: const Text(
                            "Cancel",
                          ),
                        ),
                      ),
                      Container(
                        width: 150,
                        height: 60,
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (otpController.text != '') {
                              Map param = {};
                              param['ride_id'] =
                                  '${rideResponse?.rideData?.rideId ?? 0}';
                              param['ride_status'] = Constant.TRIP_STATUS_BEGIN;
                              param["waiting_time"] = "0";
                              param["ride_otp"] = otpController.text;
                              updateRideStatus(param);
                              Navigator.of(context).pop();
                            } else {
                              Utils.snackBar('Please Enter Otp', context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: AppColors.primaryBackgroundColor,
                            // fixedSize: Size(250, 50),
                          ),
                          child: const Text(
                            "Submit",
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
