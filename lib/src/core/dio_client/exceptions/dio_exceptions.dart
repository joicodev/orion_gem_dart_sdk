part of '../client_library.dart';

String getDioErrorMessage(DioExceptionType type) {
  switch (type) {
    case DioExceptionType.connectionTimeout:
      return 'CONNECTION_TIMEOUT_MESSAGE';
    case DioExceptionType.sendTimeout:
      return 'SEND_TIMEOUT_MESSAGE';
    case DioExceptionType.receiveTimeout:
      return 'RECEIVE_TIMEOUT_MESSAGE';
    case DioExceptionType.badCertificate:
      return 'BAD_CERTIFICATE_MESSAGE';
    case DioExceptionType.badResponse:
      return 'BAD_RESPONSE_MESSAGE';
    case DioExceptionType.cancel:
      return 'REQUEST_CANCELLED_MESSAGE';
    case DioExceptionType.connectionError:
      return 'CONNECTION_ERROR_MESSAGE';
    case DioExceptionType.unknown:
      return 'UNKNOWN_ERROR_MESSAGE';
  }
}

class DIOException extends BaseException<DioExceptionType> {
  const DIOException({
    required super.error,
    required super.message,
    super.exception,
  });
}
