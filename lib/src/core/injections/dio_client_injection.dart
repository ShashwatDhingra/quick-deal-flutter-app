import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

class DioClientInjection {
  late final Dio _dio;

  DioClientInjection() {
    _dio = Dio(BaseOptions(
      baseUrl: "https://example.com/api", // Replace with your API base URL
      connectTimeout: 10.seconds,
      receiveTimeout: 10.seconds,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    //____ Add interceptors ____//
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Modify or log the request here
        if (kDebugMode) {
          print('Request: ${options.method} ${options.path}');
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // Modify or log the response here
        if (kDebugMode) {
          print('Response: ${response.data}');
        }
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        // Handle errors globally
        if (kDebugMode) {
          print('Error: ${e.message}');
        }

        return handler.next(e);
      },
    ));
  }

  Dio get dio => _dio;
}

