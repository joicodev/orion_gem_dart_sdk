part of '../client_library.dart';

enum BaseExceptionType { generic, unknown, notFound }

class BaseException<T> implements Exception {
  final T type;
  final String message;
  final Exception? exception;

  const BaseException({
    required this.message,
    required this.type,
    this.exception,
  });

  static fromUnknown(Exception? exception) {
    return BaseException(
      message: 'Unknown error exception',
      exception: exception,
      type: BaseExceptionType.unknown,
    );
  }

  static BaseException validateExceptionError<A, B>(dynamic exceptionError) {
    /* if (exceptionError.runtimeType == FirebaseAuthException) {
      final exception = exceptionError as FirebaseException;
      return AppFirebaseExceptions.fromException(exception);
    } else if (exceptionError.runtimeType == FirebaseException) {
      final exception = exceptionError as FirebaseException;
      return AppFirebaseExceptions.fromException(exception);
    } else */
    if (exceptionError.runtimeType is ArgumentError) {
      final exception = exceptionError as ArgumentError;
      return SerializingException.fromArgumentError(exception);
    }

    return BaseException.fromUnknown(null);
  }
}
