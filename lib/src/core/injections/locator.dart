import 'package:get_it/get_it.dart';

import 'dio_client_injection.dart';

final GetIt locator = GetIt.instance;

// Future<void> initInjections() async {
//   await initSharedPrefsInjections();
//   await initAppInjections();
//   await initDioInjections();
//   await initArticlesInjections();
// }

Future<void> initInjections() async {
  locator.registerLazySingleton<DioClientInjection>(() => DioClientInjection());
}
