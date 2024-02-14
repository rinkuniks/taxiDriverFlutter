import 'package:flutter/material.dart';
import 'package:rovertaxi/Utilities/Constant.dart';
import 'package:rovertaxi/model/home_Model/notificationsModel.dart';
import 'package:rovertaxi/view/bookingDetailView/bookingDetailView.dart';

import '../../Utilities/res/color.dart';
import '../../model/bookingModel/bookingModel.dart';
import '../../view_model/booking_view_model/BookingViewModel.dart';

class NotificationView extends StatefulWidget {
  final List<NotificationsList>? notificationsList;
  const NotificationView({super.key, this.notificationsList});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  BookingViewModel bookingViewModel = BookingViewModel();
  RideData? rideData;

  @override
  void initState() {
    super.initState();
  }

  ///***************** Handle Ride Status ***********************
  handleRideStatus() {
    if (rideData?.rideStatus != Constant.TRIP_STATUS_CANCELED &&
        rideData?.rideStatus != Constant.TRIP_STATUS_END) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookDetailView(rideData: rideData),
        ),
      );
    }
  }

  ///***************** GetRideStatus API ***********************
  getDriverRideStatusApi(int rideId) {
    if (rideId != 0) {
      Map param = {'ride_id': '$rideId'};
      bookingViewModel
          .getRideStatus(param, context)
          .then((value) => {rideData = value?.rideData, handleRideStatus()});
    }
  }

  ///***************** Read Notification API ***********************
  readNotificationAPI(int notifID) {
    if (notifID != 0) {
      Map param = {'push_id': '${notifID}'};
      bookingViewModel.readNotifications(param, context);
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackgroundColor,
        title: const Text('Notification'),
      ),
      body: ListView.builder(
          itemCount: widget.notificationsList?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: (() => {
                    if (widget.notificationsList?[index].rideId != null)
                      {
                        readNotificationAPI(
                            widget.notificationsList![index].pushId ?? 0),
                        getDriverRideStatusApi(
                            widget.notificationsList?[index].rideId as int)
                      }
                  }),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: (widget.notificationsList?[index].readStatus == '1')
                        ? AppColors.white
                        : AppColors.grey,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                          spreadRadius: 5)
                    ],
                  ),
                  child: ListTile(
                    title:
                        Text(widget.notificationsList?[index].message ?? 'NA'),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
