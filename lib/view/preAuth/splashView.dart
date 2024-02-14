import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rovertaxi/Utilities/res/color.dart';

import '../../Utilities/res/Assets.dart';
import '../../Utilities/routes/routes_name.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () async {
      Navigator.pushNamed(context, RoutesName.homeView);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 7,
            child: Container(
              color: AppColors.white,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: const Center(
                child: Text(
                  'Rover Taxi Driver',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryBackgroundColor),
                ),
              ),
            ),
          ),
          Expanded(
              flex: 3,
              child: Center(
                child: Lottie.asset(
                  Assets
                      .assetsSplashLottie, // Replace with the path to your Lottie JSON file
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context)
                      .size
                      .width, // Adjust the width and height as needed
                  // height: 200,
                  repeat: true, // Set to true if you want the animation to loop
                  reverse: true,
                ),
              ))
        ],
      ),
    );
  }
}
