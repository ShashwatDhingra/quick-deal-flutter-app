import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

import '../../../../core/utils/ui_utils/constants/assets.dart';
import '../../../../data/models/user_model.dart';
import '../../../global/user_provider.dart';
import '../state.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SplashState(context, ref).loadApp();
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
