import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rovertaxi/Utilities/locationManager/locationManager.dart';
import 'package:rovertaxi/Utilities/res/color.dart';
import 'package:rovertaxi/Utilities/utils.dart';
import 'package:rovertaxi/component/drawer/AppDrawer.dart';
import 'package:rovertaxi/component/homeHeader/HomeHeaderView.dart';
import 'package:rovertaxi/model/profileModel/profileModel.dart';
import 'package:rovertaxi/view/notificationView/notificationView.dart';

import '../../Utilities/Constant.dart';
import '../../Utilities/res/Assets.dart';
import '../../model/home_Model/notificationsModel.dart';
import '../../view_model/booking_view_model/BookingViewModel.dart';
import '../../view_model/homeViewModel/home_view_model.dart';
import '../../view_model/profileViewModel/ProfileViewModel.dart';
import '../bookingDetailView/bookingDetailView.dart';

class HomeView extends StatefulWidget {
  final bool? isRejected;
  const HomeView({super.key, this.isRejected});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  LatLng? currentLatLng;
  Set<Marker> markersList = {};
  late BitmapDescriptor customIcon;
  static CameraPosition initialCameraPosition = const CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962), zoom: 14);
  late GoogleMapController googleMapController;
  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );
  bool isSwitched = false;
  ProfileViewModel profileViewModel = ProfileViewModel();
  HomeViewModel homeViewModel = HomeViewModel();
  DriverProfileModel? profileModel;
  List<NotificationsList>? notificationList;
  BookingViewModel bookingViewModel = BookingViewModel();
  // RideResponse? rideResponse;

  int badgeCount = 0;
  Timer? timer;
  bool isRideRejected = false;
  @override
  void initState() {
    super.initState();
    initialSetup();
  }

  initialSetup() async {
    isRideRejected = widget.isRejected ?? false;
    getCurrentLocation();
    timer = Timer.periodic(
        const Duration(seconds: 8), (Timer t) => startUpdateDriverLocation());

    getAllNotificationApi();
    getDriverProfile();
    callRideStatusIFRideExist();
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(5, 5)), Assets.assetsCarIcon)
        .then((d) {
      customIcon = d;
    });
    print("CALLED INIT:  $currentLatLng");
  }

  getCurrentLocation() async {
    await LocationManager.instance.getCurrentLocation(context).then((value) =>
        {print('VALUE: $value'), currentLatLng = value, setMarkersOnMap()});

    /// LIVE POSITION
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position? position) {
      setState(() {
        currentLatLng = LatLng(position!.latitude, position.longitude);
        if (currentLatLng != null) {
          print('MARKER CALLEEDD');
          Future.delayed(const Duration(seconds: 1), () {
            setMarkersOnMap();
          });
        }
      });
    });
  }

  /// ******************** Set Drivers on Map ****************************
  setMarkersOnMap() {
    setState(() {
      print('CALLED MARKER');
      markersList.clear();
      markersList.add(Marker(
          markerId: const MarkerId('currentLocation'),
          icon: customIcon,
          position: currentLatLng!));
      googleMapController
          .animateCamera(CameraUpdate.newLatLngZoom(currentLatLng!, 10.0));
      print('CALLED MARKER1');
    });
  }

  ///********************* start/stop update location ********************
  stopUpdateLocation() {
    timer?.cancel();
    timer = null;
  }

  startUpdateDriverLocation() {
    // stopUpdateLocation();
    if (currentLatLng != null) {
      updateDriverLatLongAPI(currentLatLng!);
    }
  }

  ///************* Update Driver Lat Long *************
  updateDriverLatLongAPI(LatLng position) {
    Map param = {
      'latitude': '${position.latitude}',
      'longitude': '${position.longitude}'
    };
    print('LAT AND LONG: $param');
    homeViewModel.updateDriverLocation(param, context);
  }

  callRideStatusIFRideExist() async {
    var rideID = await Utils.getIntValuesSF(Constant.RIDE_ID);
    if (rideID != null && isRideRejected == false) {
      getDriverRideStatusApi(rideID);
    }
  }

  ///***************** Get Driver Profile API ***********************
  getDriverProfile() async {
    await profileViewModel.getUserProfile(context).then((value) => {
          setState(() {
            isSwitched = value.response?.driverData?.isProfileActive == '1'
                ? true
                : false;
            profileModel = value;
          })
        });
  }

  ///***************** Call Again GetAllNotifications API ***********************
  callAgainGetAllNotifApi() {
    Future.delayed(const Duration(seconds: 8), () {
      getAllNotificationApi();
    });
  }

  ///***************** GetAllNotifications API ***********************
  getAllNotificationApi() {
    Map data = {'user_type': Constant.DRIVER};
    homeViewModel.getAllNotifications(data, context).then((value) => {
          notificationList = value,
          setState(() {
            badgeCount =
                (value.where((obj) => obj.readStatus == '0').toList()).length;
          }),
          callAgainGetAllNotifApi()
        });
  }

  ///***************** GetRideStatus API ***********************
  getDriverRideStatusApi(int rideId) {
    Map param = {'ride_id': '$rideId'};
    bookingViewModel.getRideStatus(param, context).then((value) => {
          setState(() {
            // rideResponse = value;
            print('MMMMMMMMMMM: ${value?.rideData?.rideStatus}');
            if (value?.rideData != null &&
                value?.rideData?.rideStatus != Constant.TRIP_STATUS_CANCELED &&
                value?.rideData?.rideStatus != Constant.TRIP_STATUS_END) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      BookDetailView(rideData: value?.rideData),
                ),
              );
            }
          })
        });
  }

  ///***************** updateDriver Active/InActive status API ***********************
  updateDriverStatusApi(bool value) {
    Map param = {"isProfileActive": value ? "1" : "0"};
    homeViewModel
        .updateDriverStatus(param, context)
        .then((value) => setState(() {
              profileModel = value;
            }));
  }

  void toggleSwitch(bool value) {
    setState(() {
      isSwitched = value;
    });
    updateDriverStatusApi(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constant.APPNAME),
        backgroundColor: AppColors.primaryBackgroundColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: (() => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotificationView(
                                notificationsList: notificationList),
                          ),
                        )
                      }),
                ),
                badgeCount != 0
                    ? Positioned(
                        right: 3,
                        top: 3,
                        child: Container(
                          height: 18,
                          width: 18,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(9)),
                          child: Center(
                            child: Text(
                              '$badgeCount',
                            ),
                          ),
                        ))
                    : Container(),
              ],
            ),
          )
        ],
      ),
      drawer: AppDrawer(
        profileResp: profileModel?.response,
      ),
      body: Column(
        children: [
          Expanded(
              flex: 4,
              child: HomeHeaderView(
                profileResp: profileModel?.response,
                isSwitched: isSwitched,
                onSwitchSlide: ((value) => {toggleSwitch(value)}),
              )),
          Expanded(
              flex: 6,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'My Location',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      color: AppColors.primaryBackgroundColor,
                      child: GoogleMap(
                        mapType: MapType.normal,
                        myLocationEnabled: true,
                        // myLocationButtonEnabled: true,
                        initialCameraPosition: initialCameraPosition,
                        markers: markersList,
                        onMapCreated: (GoogleMapController controller) {
                          googleMapController = controller;
                        },
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
