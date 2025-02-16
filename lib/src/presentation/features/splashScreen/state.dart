import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';
import 'package:quickdeal/src/core/utils/ui_utils/helper.dart';

import '../../../core/router/routes.dart';

class SplashState {
  late BuildContext context;
  SplashState(this.context);

  Future<void> loadApp() async {
    await Future.delayed(3.seconds).then(
      (value) async {
        // Checking for User
        if (await AuthPrefHelper.isUserLogin()) {
          context.pushNamedAndRemoveUntil(Routes.dashboardScreen,
              predicate: (route) => false);
          return;
        }
        
        context.pushNamedAndRemoveUntil(Routes.onboardingScreen,
            predicate: (route) => false);
      },
    );
  }
}
