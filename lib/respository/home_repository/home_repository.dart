import '../../Utilities/res/app_url.dart';
import '../../data/network/base_api_services.dart';
import '../../data/network/network_api_services.dart';

class HomeRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  /// getAllNotifications Api
  Future<dynamic> getAllNotificationsAPI(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.getAllNotificationEndPoint, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// update Driver Status Api
  Future<dynamic> updateActiveInActive(dynamic data) async {
    try {
      dynamic response =
          _apiServices.getPostApiResponse(AppUrl.registerDriverEndPoint, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// update Driver Lat Long Api
  Future<dynamic> updateDriverLatLng(dynamic data) async {
    try {
      dynamic response = _apiServices.getPostApiResponse(
          AppUrl.updateDriverLatlangEndPoint, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Get Driver Profile Api
  Future<dynamic> getUserProfileAPI() async {
    try {
      dynamic response =
          _apiServices.getGetApiResponse(AppUrl.getUserDetailEndPoint);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
