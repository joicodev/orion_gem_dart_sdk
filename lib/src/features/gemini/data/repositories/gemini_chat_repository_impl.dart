import 'package:ai_chat_dart_sdk/ai_chat_dart_sdk.dart';
import 'package:gemini_dart_client/gemini_dart_client.dart';

class GeminiChatRepositoryImpl implements GeminiChatRepository {
  final AIChatDioClient _client;
  late final GeminiApi _geminiApi;

  GeminiChatRepositoryImpl(this._client) {
    _geminiApi = _client.geminiApi;
  }

  @override
  Future<Either<BaseException, String>> basicPrompt(
    BasicPrompParams params,
  ) async {
    return await _client.apiCall(
      converter: (String data) => data,
      apiMethod: _geminiApi.geminiControllerBasicPrompt(
        basicPromptDto: params.toBuilder(),
      ),
    );
  }
}
