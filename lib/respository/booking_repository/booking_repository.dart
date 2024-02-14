import '../../Utilities/res/app_url.dart';
import '../../data/network/base_api_services.dart';
import '../../data/network/network_api_services.dart';

class BookingRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  /// readNotification Api
  Future<dynamic> readNotifications(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.readNotifEndPoint, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Get Ride Status Api
  Future<dynamic> getRideStatusAPI(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.getRideStatusEndPoint, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Accept/Reject ride Api
  Future<dynamic> acceptRejectRideAPI(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.rideAcceptRejectEndPoint, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// update ride Api
  Future<dynamic> updateRide(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.updateRideEndPoint, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
