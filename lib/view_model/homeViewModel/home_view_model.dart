import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rovertaxi/model/home_Model/notificationsModel.dart';
import 'package:rovertaxi/respository/home_repository/home_repository.dart';

import '../../Utilities/utils.dart';
import '../../model/profileModel/profileModel.dart';

class HomeViewModel with ChangeNotifier {
  final _myRepo = HomeRepository();
  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  /// for getAllNotification
  Future<List<NotificationsList>> getAllNotifications(
      dynamic data, BuildContext context) async {
    NotificationsModel baseResponse = NotificationsModel();
    List<NotificationsList> list = [];
    setLoading(true);

    await _myRepo.getAllNotificationsAPI(data).then((value) async {
      setLoading(false);
      baseResponse = NotificationsModel.fromJson(value);
      list = baseResponse.response?.data as List<NotificationsList>;
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.toastMessage(error.toString());
      if (kDebugMode) {
        print("-----E${error.toString()}");
      }
    });
    return list;
  }

  /// for updateDriverStatus Api
  Future<DriverProfileModel> updateDriverStatus(
      dynamic data, BuildContext context) async {
    DriverProfileModel profileModel = DriverProfileModel();
    setLoading(true);
    await _myRepo.updateActiveInActive(data).then((value) async {
      setLoading(false);
      profileModel = DriverProfileModel.fromJson(value);
    }).onError((error, stackTrace) {
      setLoading(false);
      // Utils.toastMessage(error.toString());
      if (kDebugMode) {
        print("-----E${error.toString()}");
      }
    });
    return profileModel;
  }

  /// for update Driver Location Api
  Future<void> updateDriverLocation(dynamic data, BuildContext context) async {
    // DriverProfileModel profileModel = DriverProfileModel();
    setLoading(true);
    await _myRepo.updateDriverLatLng(data).then((value) async {
      setLoading(false);
      // profileModel = DriverProfileModel.fromJson(value);
    }).onError((error, stackTrace) {
      setLoading(false);
      // Utils.toastMessage(error.toString());
      if (kDebugMode) {
        print("-----E${error.toString()}");
      }
    });
    // return profileModel;
  }
}
