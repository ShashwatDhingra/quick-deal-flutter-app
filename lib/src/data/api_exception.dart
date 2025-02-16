import 'package:dio/dio.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';

class AppException implements Exception {
  final String _message;
  final String _prefix;

  AppException(this._message, this._prefix);

  String get message => _message; // ✅ Add this getter

  @override
  String toString() {
    return '$_prefix: $_message';
  }
}

class FetchDataException extends AppException {
  FetchDataException(String message)
      : super(message, 'Error During Communication');
}

class BadRequestException extends AppException {
  BadRequestException(String message) : super(message, 'Invalid Request');
}

class UnauthorizedException extends AppException {
  UnauthorizedException(String message)
      : super(message, 'Unauthorized request');
}

class NotFoundException extends AppException {
  NotFoundException(String message) : super(message, 'Not Found');
}

class InvalidInputException extends AppException {
  InvalidInputException(String message) : super(message, 'Invalid Input');
}

//** To show the Error on UI **//
void handleError(dynamic e) {
  String errorMessage;

  if (e is AppException) {
    // Handle custom exceptions (UnauthorizedException, BadRequestException, etc.)
    errorMessage = e.toString();
  } else if (e is DioException) {
    // Handle DioError (API-specific errors)
    if (e.response != null) {
      final statusCode = e.response!.statusCode ?? 500;
      final message = e.response!.data["error"] ?? "Unknown error";
      errorMessage = _getDioErrorMessage(statusCode, message);
    } else {
      errorMessage =
          "No response from server. Check you Internet or Try again !";
    }
  } else {
    // General error
    errorMessage = "An unexpected error occurred: $e";
  }

  // Show the error message
  errorMessage.showErrorToast();
}

String _getDioErrorMessage(int statusCode, String message) {
  switch (statusCode) {
    case 400:
      return "Bad Request: $message";
    case 401:
      return "Unauthorized:\n$message";
    case 404:
      return "Not Found: $message";
    case 500:
      return "Internal Server Error: $message";
    default:
      return "Error: $message";
  }
}
