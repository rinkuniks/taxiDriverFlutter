import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rovertaxi/model/bookingModel/bookingModel.dart';

import '../../Utilities/Constant.dart';
import '../../Utilities/utils.dart';
import '../../respository/booking_repository/booking_repository.dart';

class BookingViewModel with ChangeNotifier {
  final _myRepo = BookingRepository();
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  /// for readNotification
  Future<void> readNotifications(dynamic data, BuildContext context) async {
    // CreateRideResponse createRideResponse = CreateRideResponse();
    setLoading(true);
    Utils.alertLoader(context);
    await _myRepo.readNotifications(data).then((value) async {
      setLoading(false);
      Utils.disableLoader(context);
      // createRideResponse = CreateRideResponse.fromJson(value['response']);
      // if (createRideResponse.code == 200) {}
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.toastMessage(error.toString());
      if (kDebugMode) {
        print("-----Read Notif${error.toString()}");
      }
    });
    // return createRideResponse;
  }

  /// for Accept/Reject Ride
  Future<RideResponse?> acceptRejectRide(
      dynamic data, BuildContext context) async {
    BookingModel bookingModel = BookingModel();
    setLoading(true);
    // Utils.alertLoader(context);
    await _myRepo.acceptRejectRideAPI(data).then((value) async {
      setLoading(false);
      // Utils.disableLoader(context);
      // Utils.removeValuesSF(Constant.RIDE_DATA);
      bookingModel = BookingModel.fromJson(value);
      // if (createRideResponse.code == 200) {}
    }).onError((error, stackTrace) {
      setLoading(false);
      // Utils.toastMessage(error.toString());
      if (kDebugMode) {
        print("-----AcceptReject RIDE${error.toString()}");
      }
    });
    return bookingModel.response;
  }

  /// for Update Ride
  Future<RideResponse?> updateRideAPI(
      dynamic data, BuildContext context) async {
    BookingModel bookingModel = BookingModel();
    setLoading(true);
    // Utils.alertLoader(context);
    await _myRepo.updateRide(data).then((value) async {
      setLoading(false);
      // Utils.disableLoader(context);
      // Utils.removeValuesSF(Constant.RIDE_DATA);
      bookingModel = BookingModel.fromJson(value);
      // if (createRideResponse.code == 200) {}
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.toastMessage(error.toString());
      if (kDebugMode) {
        print("-----Update RIDE${error.toString()}");
      }
    });
    return bookingModel.response;
  }

  /// for Get Ride Status
  Future<RideResponse?> getRideStatus(
      dynamic data, BuildContext context) async {
    BookingModel bookingModel = BookingModel();
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      setLoading(true);
      // Utils.alertLoader(context);
      await _myRepo.getRideStatusAPI(data).then((value) async {
        setLoading(false);
        // Utils.disableLoader(context);
        bookingModel = BookingModel.fromJson(value);

        ///Save response in local
        if (bookingModel.response?.rideData?.rideId != null) {
          Utils.addIntToSF(
              Constant.RIDE_ID, bookingModel.response?.rideData?.rideId ?? 0);
        }
        String encodeData = jsonEncode(bookingModel.response);
        Utils.addStringToSF(Constant.RIDE_DATA, encodeData);
        if (bookingModel.response?.code == 200) {}
      }).onError((error, stackTrace) {
        setLoading(false);
        // Utils.toastMessage(error.toString());
        if (kDebugMode) {
          print("-----GET RIDE STATUS${error.toString()}");
        }
      });
      return bookingModel.response;
    } else {
      return await getRideDataFromLocal();
    }
  }

  Future<RideResponse> getRideDataFromLocal() async {
    RideResponse rideResponse = RideResponse();
    String? rideDataStr = await Utils.getStringValuesSF(Constant.RIDE_DATA);
    if (rideDataStr != null) {
      Map<String, dynamic> jsonData = json.decode(rideDataStr);
      rideResponse = RideResponse.fromJson(jsonData);
    }
    return rideResponse;
  }
}
