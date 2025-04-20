/* import 'package:cloud_firestore/cloud_firestore.dart';

import 'base_exception.dart';

enum FirebaseExceptionErrorType {
  permissionDenied('permission-denied'),
  invalidCredentials('invalid-credential'),
  emailAlreadyInUse('email-already-in-use'),
  usernameAlreadyInUse('username-already-in-use'),
  celebrityAlreadyStartedLive('celebrity-already-started-live'),
  celebrityHasNotStartedLive('celebrity-has-not-started-live'),
  weakPassword('weak-password'),
  // For "requiresRecentLogin" need: await user?.reauthenticateWithCredential(credential);
  requiresRecentLogin("requires-recent-login"),
  unknown('');

  const FirebaseExceptionErrorType(this.code);

  final String code;

  @override
  String toString() => code;

  static FirebaseExceptionErrorType valueOf(String value) {
    return FirebaseExceptionErrorType.values.firstWhere(
      (type) => type.code == value,
      orElse: () => FirebaseExceptionErrorType.unknown,
    );
  }
}

class AppFirebaseExceptions extends BaseException<FirebaseException> {
  const AppFirebaseExceptions({
    required super.error,
    required super.message,
    super.exception,
  });

  factory AppFirebaseExceptions.fromException(FirebaseException exception) {
    return AppFirebaseExceptions(
      message: exception.message ?? '',
      error: exception,
      exception: exception,
    );
  }
}
 */
