import 'package:ai_chat_dart_sdk/ai_chat_dart_sdk.dart';
import 'package:ai_chat_dart_sdk/src/core/dio_client/client_library.dart';

abstract class GeminiChatRepository {
  Future<Either<BaseException, String>> basicPrompt(BasicPromptDto prompt);
}
