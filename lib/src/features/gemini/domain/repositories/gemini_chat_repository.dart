import 'package:orion_gem_dart_sdk/orion_gem_dart_sdk.dart';

abstract class GeminiChatRepository {
  Future<Either<BaseException, String>> basicPrompt(BasicPrompParams prompt);

  Future<Either<BaseException, String>> basicPromptStream(
    BasicPromptStreamParams prompt,
  );
}
