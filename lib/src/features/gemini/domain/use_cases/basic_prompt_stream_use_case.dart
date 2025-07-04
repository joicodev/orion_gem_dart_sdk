import 'dart:io';

import 'package:built_value/serializer.dart';
import 'package:orion_gem_dart_sdk/orion_gem_dart_sdk.dart';
import 'package:orion_gem_nest_dart_client/orion_gem_nest_dart_client.dart';

/// This class is used to execute the [BasicPromptStreamUseCase].
class BasicPromptStreamUseCase
    extends BaseUseCases<BasicPromptStreamParams, Stream<String>> {
  /// The repository to be used to execute the [BasicPromptStreamUseCase].
  final GeminiChatRepository _repository;

  BasicPromptStreamUseCase(this._repository);

  @override
  Future<Either<BaseException, Stream<String>>> execute(
    BasicPromptStreamParams params,
  ) async {
    return await _repository.basicPromptStream(params);
  }
}

/// This class is used to pass the prompt to the [BasicPromptStreamUseCase].
class BasicPromptStreamParams {
  /// The prompt to be sent to the Gemini API.
  final String prompt;

  final List<File> files;

  BasicPromptStreamParams({required this.prompt, required this.files});

  /// This function is used to convert the [BasicPrompParams] to a [BasicPromptDto].
  BasicPromptDto toBuilder() {
    return BasicPromptDto((b) => b.prompt = prompt);
  }

  /// This function is used to convert the [BasicPromptStreamParams] to a JSON map.
  Object buildObject() {
    final Serializers serializers = standardSerializers;
    final bodyData = serializers.serialize(
      toBuilder(),
      specifiedType: FullType(BasicPromptDto),
    );

    return bodyData!;
  }
}
