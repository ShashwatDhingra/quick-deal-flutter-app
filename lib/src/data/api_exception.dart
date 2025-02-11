class AppException implements Exception {
  final String _message;
  final String _prefix;

  AppException(this._message, this._prefix);

  @override
  String toString() {
    return '$_prefix$_message';
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
void handleError(Exception e, Function(String) callBack) {
  String errorMessage;

  if (e is FetchDataException) {
    errorMessage = e.toString();
  } else if (e is BadRequestException) {
    errorMessage = e.toString();
  } else if (e is UnauthorizedException) {
    errorMessage = e.toString();
  } else {
    errorMessage = 'An unexpected error occurred: $e';
  }

  callBack(errorMessage);
}
