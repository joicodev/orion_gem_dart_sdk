import 'package:orion_gem_dart_client/orion_gem_dart_client.dart';
import 'package:orion_gem_dart_sdk/orion_gem_dart_sdk.dart';

class GeminiChatRepositoryImpl implements GeminiChatRepository {
  final OrionGemChatDioClient _client;
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
