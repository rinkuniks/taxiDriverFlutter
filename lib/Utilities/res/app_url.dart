class AppUrl {
  //Base URL
  static var baseUrl = 'https://rovertaxi-dev.affleprojects.com/api/v2';
  static var googleDirectionUrl =
      'https://maps.googleapis.com/maps/api/directions/json?key=';
  static var placeholderImgUrl =
      'https://www.kasandbox.org/programming-images/avatars/spunky-sam.png';
  static var driverplaceholderImgUrl =
      'https://www.kasandbox.org/programming-images/avatars/spunky-sam-green.png';

  //Auth URLS
  static var loginEndPoint = '$baseUrl/login';
  static var logoutApiEndPoint = '$baseUrl/logout';
  static var getAllNotificationEndPoint = '$baseUrl/getAllNotifications';
  static var registerDriverEndPoint = '$baseUrl/registerDriver';
  static var readNotifEndPoint = '$baseUrl/readNotification';
  static var updateRideEndPoint = '$baseUrl/updateRide';
  static var getRideStatusEndPoint = '$baseUrl/getRideStatus';
  static var getUserDetailEndPoint = '$baseUrl/driverProfile';
  static var rideAcceptRejectEndPoint = '$baseUrl/rideRequest';
  static var updateDriverLatlangEndPoint = '$baseUrl/updateDriverLatLng';
}
