import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

import '../../../../core/utils/ui_utils/constants/assets.dart';
import '../state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SplashState(context).loadApp();
  }

  @override
  Widget build(BuildContext context) {
    var dark = context.isDarkMode;
    return Scaffold(
      body: Center(
          child: LottieBuilder.asset(
        dark ? AssetsConsts.quickDealDarkAnim : AssetsConsts.quickDealLightAnim,
        repeat: false,
      )),
    );
  }
}
