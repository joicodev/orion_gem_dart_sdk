import 'package:ai_chat_dart_sdk/ai_chat_dart_sdk.dart';
import 'package:ai_chat_dart_sdk/src/core/dio_client/client_library.dart';

class BasicPromptUseCase extends BaseUseCases<BasicPromptDto, String> {
  final GeminiChatRepository _repository;

  BasicPromptUseCase(this._repository);

  @override
  Future<Either<BaseException, String>> execute(BasicPromptDto params) async {
    return await _repository.basicPrompt(params);
  }
}
