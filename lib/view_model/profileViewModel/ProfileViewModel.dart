import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rovertaxi/respository/home_repository/home_repository.dart';

import '../../Utilities/Constant.dart';
import '../../Utilities/utils.dart';
import '../../model/profileModel/profileModel.dart';

class ProfileViewModel with ChangeNotifier {
  final _myRepo = HomeRepository();
  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  /// for Get Driver Profile
  Future<DriverProfileModel> getUserProfile(BuildContext context) async {
    DriverProfileModel profileModel = DriverProfileModel();
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      setLoading(true);
      await _myRepo.getUserProfileAPI().then((value) async {
        setLoading(false);
        profileModel = DriverProfileModel.fromJson(value);
        String encodeData = jsonEncode(profileModel.response);
        Utils.addStringToSF(Constant.PROFILE_DATA, encodeData);
      }).onError((error, stackTrace) {
        setLoading(false);
        // Utils.toastMessage(error.toString());
        if (kDebugMode) {
          print("-----E${error.toString()}");
        }
      });
      return profileModel;
    } else {
      return getProfileDataFromLocal();
    }
  }

  Future<DriverProfileModel> getProfileDataFromLocal() async {
    DriverProfileModel profileModel = DriverProfileModel();
    String? profileDataStr =
        await Utils.getStringValuesSF(Constant.PROFILE_DATA);
    if (profileDataStr != null) {
      Map<String, dynamic> jsonData = json.decode(profileDataStr);
      profileModel = DriverProfileModel.fromJson(jsonData);
    }
    return profileModel;
  }
}
