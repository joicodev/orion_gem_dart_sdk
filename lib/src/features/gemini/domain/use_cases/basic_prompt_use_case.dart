import 'package:ai_chat_dart_sdk/ai_chat_dart_sdk.dart';
import 'package:ai_chat_dart_sdk/src/core/dio_client/client_library.dart';
import 'package:gemini_dart_client/gemini_dart_client.dart';

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
