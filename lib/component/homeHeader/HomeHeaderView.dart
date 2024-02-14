import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rovertaxi/model/profileModel/profileModel.dart';

import '../../Utilities/res/Assets.dart';
import '../../Utilities/res/app_url.dart';
import '../../Utilities/res/color.dart';

class HomeHeaderView extends StatefulWidget {
  final bool? isSwitched;
  final ProfileResponse? profileResp;
  final Function? onSwitchSlide;
  const HomeHeaderView(
      {super.key, this.isSwitched, this.profileResp, this.onSwitchSlide});

  @override
  State<HomeHeaderView> createState() => _HomeHeaderViewState();
}

class _HomeHeaderViewState extends State<HomeHeaderView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 210,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Assets.assetsHomeBanner), fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 110,
                      height: 40,
                      decoration: BoxDecoration(
                          color: AppColors.primaryBackgroundColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            Assets.assetsEdit,
                            height: 20,
                            width: 20,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Edit',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: AppColors.white),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(45),
                          border: Border.all(width: 3, color: AppColors.white)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(45.0),
                        child: FadeInImage.assetNetwork(
                          placeholder: Assets.assetsPlaceholder,
                          image: widget.profileResp?.driverData?.profileImage ??
                              AppUrl.driverplaceholderImgUrl,
                        ),
                      ),
                    ),
                    Container(
                      width: 110,
                      height: 40,
                      decoration: BoxDecoration(
                          color: AppColors.primaryBackgroundColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Active',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: AppColors.white),
                          ),
                          Transform.scale(
                            scale: 1.2,
                            child: Switch(
                              onChanged: ((value) =>
                                  {widget.onSwitchSlide!(value)}),
                              value: widget.isSwitched ?? false,
                              activeColor: Colors.white,
                              activeTrackColor: Colors.green,
                              inactiveThumbColor: Colors.white,
                              inactiveTrackColor: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.profileResp?.driverData?.name ?? 'NA',
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: AppColors.white),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.profileResp?.driverData?.phone ?? 'NA',
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white),
                ),
                const SizedBox(
                  height: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RatingBar.builder(
                      initialRating: double.parse(
                          widget.profileResp?.driverData?.rating ?? '0.0'),
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 20,
                      unratedColor: AppColors.white,
                      // itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    Text(
                      widget.profileResp?.driverData?.rating ?? 'NA',
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: AppColors.white),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 5,
                spreadRadius: 5)
          ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  'Current Outstanding',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Booking',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      '${widget.profileResp?.driverData?.totalRides ?? 0}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Earning',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      '\$${widget.profileResp?.driverData?.totalEarnings ?? 0.0}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
