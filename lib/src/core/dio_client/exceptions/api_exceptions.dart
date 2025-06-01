part of '../client_library.dart';

enum APIExceptionErrorType {
  invalidArgument,
  notFound,
  unknown;

  const APIExceptionErrorType();

  static APIExceptionErrorType valueOf(String value) {
    final formattedValue = value.replaceAll("_", "").toLowerCase();
    return APIExceptionErrorType.values.firstWhere((type) {
      return type.toString().split('.').last.toLowerCase() == formattedValue;
    }, orElse: () => APIExceptionErrorType.unknown);
  }
}

class APIException extends BaseException<APIExceptionErrorType> {
  const APIException({
    required super.type,
    required super.message,
    super.exception,
  });
}
