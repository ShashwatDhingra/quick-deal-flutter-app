
import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

import '../../../core/router/routes.dart';

class SplashState {
  late BuildContext context;
  SplashState(this.context);

  Future<void> loadApp() async {
    await Future.delayed(3.seconds).then(
      (value) {
        context.pushNamedAndRemoveUntil(Routes.onboardingScreen,
            predicate: (route) => false);
      },
    );
  }
}
