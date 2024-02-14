import 'package:flutter/material.dart';

import '../../Utilities/res/Assets.dart';
import '../../Utilities/res/app_url.dart';
import '../../Utilities/res/color.dart';
import '../../model/bookingModel/bookingModel.dart';

class AcceptRejectView extends StatefulWidget {
  final Function? onTapAcceptReject;
  final RideResponse? rideResponse;
  final String? acceptTitleStr;
  final String? rejectTitleStr;

  const AcceptRejectView({
    super.key,
    this.onTapAcceptReject,
    this.rideResponse,
    this.acceptTitleStr,
    this.rejectTitleStr,
  });

  @override
  State<AcceptRejectView> createState() => _AcceptRejectViewState();
}

class _AcceptRejectViewState extends State<AcceptRejectView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 85,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(width: 3, color: AppColors.black)),
                      child: FadeInImage.assetNetwork(
                        placeholder: Assets.assetsPlaceholder,
                        image: widget.rideResponse?.userData?.userImage ??
                            AppUrl.placeholderImgUrl,
                        // width: 60,
                        // height: 60,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 110,
                          child: Text(
                            widget.rideResponse?.userData?.name ?? 'NA',
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: 110,
                          child: Text(
                              widget.rideResponse?.userData?.phone ?? 'NA',
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.grey)),
                        ),
                      ],
                    ),
                    const Icon(Icons.star_border_purple500_outlined),
                    Text(
                      widget.rideResponse?.userData?.rating ?? 'NA',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400),
                    )
                  ],
                ),
                Container(
                  width: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 2, color: AppColors.grey),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.rideResponse?.rideData?.rideStatus ?? 'NA',
                        style: const TextStyle(
                            color: AppColors.primaryBackgroundColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        widget.rideResponse?.taxiData?.taxiTypeInfo?.taxiName ??
                            'NA',
                        maxLines: 1,
                        style: const TextStyle(
                            color: AppColors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                          width: 100,
                          height: 18,
                          child: Image.asset(Assets.assetsTaxiGrey)),
                      Text(
                        widget.rideResponse?.taxiData
                                ?.vehicleRegistrationNumber ??
                            'NA',
                        maxLines: 1,
                        style: const TextStyle(
                            color: AppColors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 1,
            color: AppColors.grey,
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 12,
                      width: 12,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.green),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        widget.rideResponse?.rideData?.pickupAddress ?? 'NA',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                Image.asset(
                  Assets.assetsLocationDots,
                  width: 8,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                Row(
                  children: [
                    Container(
                      height: 12,
                      width: 12,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: AppColors.primaryBackgroundColor),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        widget.rideResponse?.rideData?.dropAddress ?? 'NA',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: AppColors.primaryBackgroundColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Distance',
                      style: TextStyle(
                          color: AppColors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      widget.rideResponse?.rideData?.distance ?? 'NA',
                      style: const TextStyle(
                          color: AppColors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Bill',
                      style: TextStyle(
                          color: AppColors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        Text(
                          '\$${widget.rideResponse?.rideData?.actualCost != '0' ? widget.rideResponse?.rideData?.actualCost : widget.rideResponse?.rideData?.estimatedCost}',
                          style: const TextStyle(
                              color: AppColors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          'Unpaid',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Waiting Time',
                      style: TextStyle(
                          color: AppColors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '00',
                      style: TextStyle(
                          color: AppColors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                widget.rejectTitleStr != ''
                    ? InkWell(
                        onTap: (() => {widget.onTapAcceptReject!(0)}),
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border:
                                  Border.all(color: AppColors.grey, width: 2)),
                          child: Center(
                            child: Text(
                              widget.rejectTitleStr ?? 'NA',
                              style: const TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      )
                    : Container(),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: (() => {widget.onTapAcceptReject!(1)}),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.primaryBackgroundColor,
                    ),
                    child: Center(
                      child: Text(
                        widget.acceptTitleStr ?? 'NA',
                        style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
