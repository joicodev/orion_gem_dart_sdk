part of '../client_library.dart';

abstract class BaseUseCases<Parameters, T> {
  Future<Either<Exception, T>> execute(Parameters params);
}

abstract class BaseUseCasesNoParams<T> {
  Future<Either<Exception, T>> execute();
}
