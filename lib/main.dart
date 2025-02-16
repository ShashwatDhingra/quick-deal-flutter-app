import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickdeal/src/core/utils/ui_utils/helper.dart';
import 'src/core/injections/locator.dart';
import 'src/core/router/route_generator.dart';
import 'src/core/utils/ui_utils/display.dart';
import 'src/core/utils/ui_utils/loading_manager.dart';
import 'src/core/utils/ui_utils/theme/theme.dart';

void main() async {
  await initInjections();
  runApp(const ProviderScope(child: HRNext()));
}

class HRNext extends StatelessWidget {
  const HRNext({super.key});

  @override
  Widget build(BuildContext context) {
    //** Context required Initializations **//
    // ScreenSize().init(context);

    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    ScreenUtilService.init(context);
    // });
    PrefHelper.initSharedPref();

    return MaterialApp(
      navigatorKey: LoadingManager.navigatorKey,
      themeMode: ThemeMode.system,
      theme: CAppTheme.lightTheme,
      darkTheme: CAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
