import 'package:orion_gem_dart_sdk/orion_gem_dart_sdk.dart';
import 'package:orion_gem_nest_dart_client/orion_gem_nest_dart_client.dart';

/// This class is used to execute the [BasicPromptUseCase].
class BasicPromptUseCase extends BaseUseCases<BasicPrompParams, String> {
  /// The repository to be used to execute the [BasicPromptUseCase].
  final GeminiChatRepository _repository;

  BasicPromptUseCase(this._repository);

  @override
  Future<Either<BaseException, String>> execute(BasicPrompParams params) async {
    return await _repository.basicPrompt(params);
  }
}

/// This class is used to pass the prompt to the [BasicPromptUseCase].
class BasicPrompParams {
  /// The prompt to be sent to the Gemini API.
  final String prompt;

  BasicPrompParams({required this.prompt});

  /// This function is used to convert the [BasicPrompParams] to a [BasicPromptDto].
  BasicPromptDto toBuilder() {
    return BasicPromptDto((b) => b.prompt = prompt);
  }
}
