import 'package:orion_gem_dart_sdk/orion_gem_dart_sdk.dart';

Future<void> main() async {
  // Instantiate your use case with the HTTP client
  final basicPromptStreamUseCase = BasicPromptStreamUseCase(
    GeminiChatRepositoryImpl(SdkDioClient('http://192.168.1.107:3000/')),
  );

  // Execute the stream prompt and await the Either<BaseException, String>
  final result = await basicPromptStreamUseCase.execute(
    BasicPromptStreamParams(prompt: 'What is the History of Venezuela?'),
  );

  // Handle error or success
  result.fold(
    (error) {
      // English comment: print error message if request failed
      print('Error: ${error.message}');
    },
    (fullText) async {
      // English comment: print the complete streamed response
      await for (final chunk in fullText) {
        print(chunk);
      }
    },
  );
}
