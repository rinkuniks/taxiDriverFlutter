import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rovertaxi/Utilities/Constant.dart';
import 'package:rovertaxi/Utilities/res/app_url.dart';
import 'package:rovertaxi/model/profileModel/profileModel.dart';

import '../../Utilities/res/Assets.dart';
import '../../Utilities/res/color.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key, this.profileResp});

  final ProfileResponse? profileResp;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primaryBackgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 270,
            child: DrawerHeader(
              decoration: const BoxDecoration(
                  // color: Colors.transparent,
                  ),
              child: Column(
                children: [
                  Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.white, width: 4)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: FadeInImage.assetNetwork(
                          placeholder: Assets.assetsPlaceholder,
                          image: profileResp?.driverData?.profileImage ??
                              AppUrl.placeholderImgUrl,
                          // width: 60,
                          // height: 60,
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    profileResp?.driverData?.name ?? "NA",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.white),
                  ),
                  Text(
                    profileResp?.driverData?.phone ?? "NA",
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: AppColors.white),
                  ),
                  RatingBar.builder(
                    initialRating:
                        double.parse(profileResp?.driverData?.rating ?? '0.0'),
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 25,
                    // itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: AppColors.white,
          ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            title: const Text(
              Constant.HOME,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white),
            ),
            leading: const Icon(
              Icons.home,
              color: AppColors.white,
            ),
            // selected: _selectedIndex == 0,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text(
              Constant.HISTORY,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white),
            ),
            leading: const Icon(
              Icons.history,
              color: AppColors.white,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text(
              Constant.FAQ,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white),
            ),
            leading: const Icon(
              Icons.question_answer,
              color: AppColors.white,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text(
              Constant.DELETE_ACCOUNT,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white),
            ),
            leading: const Icon(
              Icons.delete,
              color: AppColors.white,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text(
              Constant.LOGOUT,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white),
            ),
            leading: const Icon(
              Icons.logout,
              color: AppColors.white,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
