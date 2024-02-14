class NotificationsModel {
  NotifListResponse? response;

  NotificationsModel({this.response});

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    response = json['response'] != null
        ? NotifListResponse.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (response != null) {
      data['response'] = response!.toJson();
    }
    return data;
  }
}

class NotifListResponse {
  String? message;
  List<NotificationsList>? data;
  int? totalUnreadCount;
  int? totalNotification;
  int? code;

  NotifListResponse(
      {this.message,
      this.data,
      this.totalUnreadCount,
      this.totalNotification,
      this.code});

  NotifListResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <NotificationsList>[];
      json['data'].forEach((v) {
        data!.add(NotificationsList.fromJson(v));
      });
    }
    totalUnreadCount = json['total_unread_count'];
    totalNotification = json['total_notification'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total_unread_count'] = totalUnreadCount;
    data['total_notification'] = totalNotification;
    data['code'] = code;
    return data;
  }
}

class NotificationsList {
  int? pushId;
  String? type;
  dynamic? rideId;
  String? notificationFor;
  String? viewPush;
  int? userId;
  String? message;
  String? readStatus;
  String? expiryTimestamp;

  NotificationsList(
      {this.pushId,
      this.type,
      this.rideId,
      this.notificationFor,
      this.viewPush,
      this.userId,
      this.message,
      this.readStatus,
      this.expiryTimestamp});

  NotificationsList.fromJson(Map<String, dynamic> json) {
    pushId = json['push_id'];
    type = json['type'];
    rideId = json['ride_id'];
    notificationFor = json['notification_for'];
    viewPush = json['view_push'];
    userId = json['user_id'];
    message = json['message'];
    readStatus = json['read_status'];
    expiryTimestamp = json['expiry_timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['push_id'] = pushId;
    data['type'] = type;
    data['ride_id'] = rideId;
    data['notification_for'] = notificationFor;
    data['view_push'] = viewPush;
    data['user_id'] = userId;
    data['message'] = message;
    data['read_status'] = readStatus;
    data['expiry_timestamp'] = expiryTimestamp;
    return data;
  }
}
