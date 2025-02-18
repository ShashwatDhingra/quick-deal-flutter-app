import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';
import 'package:quickdeal/src/core/utils/ui_utils/helper.dart';
import 'package:quickdeal/src/presentation/features/dashboard/subscreens/profile/profile.dart';

import '../../../core/router/routes.dart';
import '../../../data/models/user_model.dart';
import '../../global/user_provider.dart';

class SplashState {
  late BuildContext context;
  late WidgetRef ref;
  SplashState(this.context, this.ref);

  Future<void> loadApp() async {
    await Future.delayed(3.seconds).then(
      (value) async {
        // Checking for User
        if (await AuthPrefHelper.isUserLogin()) {
          // Load data of user in global provider.
          final userDetail = await loadUserDetail();
          ref.read(userProvider.notifier).setUser(User.fromJson(userDetail));
          return context.pushNamedAndRemoveUntil(Routes.dashboardScreen,
              predicate: (route) => false);
        }

        context.pushNamedAndRemoveUntil(Routes.onboardingScreen,
            predicate: (route) => false);
      },
    );
  }

  Future<dynamic> loadUserDetail() async {
    // Getting detail from jwt.
    return JwtDecoder.decode(await AuthPrefHelper.getUserToken() ?? '');
  }
}
