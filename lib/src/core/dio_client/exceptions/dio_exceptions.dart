part of '../client_library.dart';

class DIOException extends BaseException<DioExceptionType> {
  const DIOException({
    required super.type,
    required super.message,
    super.exception,
  });
}
