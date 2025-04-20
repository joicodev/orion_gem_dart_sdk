part of '../client_library.dart';

enum SerializingExceptionErrorType {
  argumentsError,
  serializeData,
  unknown;

  const SerializingExceptionErrorType();

  static SerializingExceptionErrorType valueOf(String value) {
    return SerializingExceptionErrorType.values.firstWhere(
      (type) => type.toString().split('.').last == value,
      orElse: () => SerializingExceptionErrorType.unknown,
    );
  }
}

class SerializingException
    extends BaseException<SerializingExceptionErrorType> {
  const SerializingException({
    required super.error,
    required super.message,
    super.exception,
  });

  static fromArgumentError(ArgumentError error) {
    return SerializingException(
      message: error.name ?? error.message,
      error: SerializingExceptionErrorType.argumentsError,
      exception: Exception(error.message),
    );
  }
}
