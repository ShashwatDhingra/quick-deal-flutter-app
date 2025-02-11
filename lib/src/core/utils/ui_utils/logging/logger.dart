import 'package:logger/logger.dart';

mixin LogUtil {
  void debugLog(message, [Object? error, StackTrace? stackTrace]) {
    Logger().d(message, error: error, stackTrace: stackTrace);
  }

  void errorLog(message, [Object? error, StackTrace? stackTrace]) {
    Logger().e(message, error: error, stackTrace: stackTrace);
  }

  void infoLog(message, [Object? error, StackTrace? stackTrace]) {
    Logger().i(message, error: error, stackTrace: stackTrace);
  }

  void verboseLog(message, [Object? error, StackTrace? stackTrace]) {
    Logger().t(message, error: error, stackTrace: stackTrace);
  }

  void wtfLog(message, [Object? error, StackTrace? stackTrace]) {
    Logger().f(message, error: error, stackTrace: stackTrace);
  }
}
