import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:orion_gem_nest_dart_client/orion_gem_nest_dart_client.dart';

Future<void> main() async {
  final dio = Dio(BaseOptions(baseUrl: 'http://192.168.1.108:3000/'));
  final rs = await dio.post<ResponseBody>(
    'api/gemini/basic-prompt-stream',
    options: Options(responseType: ResponseType.stream),
    data: {"prompt": "What is the History of Venezuela?"},
  );

  print('THE TYPE IS >>> ${rs.data.runtimeType}');

  await for (final chunk in rs.data!.stream) {
    final decodedString = utf8.decode(chunk);
    print(decodedString);
  }
}

/* void main2() async {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.1.108:3000/',
      responseType: ResponseType.plain,
      headers: {"Accept": "text/event-stream", "Cache-Control": "no-cache"},
    ),
  );

  final api = OrionGemNestDartClient(dio: dio).getGeminiApi();
  final BasicPromptDto basicPromptDto = BasicPromptDto(
    (b) => b.prompt = 'What is the History of Venezuela?',
  );

  try {
    // Await the response
    final response = await api.geminiControllerBasicPromptStreamExample(
      basicPromptDto: basicPromptDto,
    );

    // The response.data is now a complete String. Just print it.
    if (response.data != null) {
      print('==============================');
      print(response.data.runtimeType);
    }
  } catch (e) {
    print(
      'Exception when calling GeminiApi->geminiControllerBasicPromptStream: $e\n',
    );
  }
}
 */
