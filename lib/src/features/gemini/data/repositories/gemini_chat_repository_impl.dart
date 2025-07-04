import 'dart:convert';
import 'dart:typed_data';

import 'package:orion_gem_dart_sdk/orion_gem_dart_sdk.dart';
import 'package:orion_gem_nest_dart_client/orion_gem_nest_dart_client.dart';

class GeminiChatRepositoryImpl implements GeminiChatRepository {
  final SdkDioClient _sdkDioHttp;
  late final GeminiApi _geminiApi;

  GeminiChatRepositoryImpl(this._sdkDioHttp) {
    _geminiApi = _sdkDioHttp.instance.getGeminiApi();
  }

  @override
  Future<Either<BaseException, String>> basicPrompt(
    BasicPrompParams params,
  ) async {
    return await _sdkDioHttp.apiCall(
      converter: (String data) => data,
      apiMethod: _geminiApi.geminiControllerBasicPrompt(
        basicPromptDto: params.toBuilder(),
      ),
    );
  }

  @override
  Future<Either<BaseException, Stream<String>>> basicPromptStream(
    BasicPromptStreamParams params,
  ) async {
    try {
      /* await _sdkDioHttp.apiCall(
        converter: (Uint8List data) {
          final stream = Stream.value(data).map((chunk) {
            print('Chunk !> $chunk');
            return utf8.decode(chunk, allowMalformed: true);
          });

          return stream;
        },
        apiMethod: _geminiApi.geminiControllerBasicPromptAssetsStreamV2(
          prompt: params.prompt,
          headers: {
            'Accept': 'text/event-stream',
            'Content-Type': 'application/json',
            "Cache-Control": "no-cache",
          },
        ),
      ); */

      /* final request = await _geminiApi
          .geminiControllerBasicPromptAssetsStreamV2(
            prompt: params.prompt,
            // files: params.files,
            headers: {
              'Accept': 'text/event-stream',
              'Content-Type': 'application/json',
            },
          );

      print('DATA RERTURNED....');

      // Convert Response<Uint8List> to Stream<String>
      final stream = Stream.value(
        request.data!,
      ).map((chunk) => utf8.decode(chunk, allowMalformed: true)); */

      final rs = await _sdkDioHttp.streamApiCall(
        path: '/api/gemini/basic-prompt-stream',
        body: params.buildObject(),
        headers: {
          'Accept': 'text/event-stream',
          'Content-Type': 'application/json',
        },
      );

      print('RESULT HERE !>>>>>>');

      // Map the raw byte-stream to a decoded String stream
      final stringStream = rs.data!.stream.map(
        (chunk) => utf8.decode(chunk, allowMalformed: true),
      );

      // Return the stream wrapped in Right
      return Right(stringStream);
    } on DioException catch (e) {
      return Left(
        DIOException(message: e.message ?? 'Unknown error', type: e.type),
      );
    }
  }
}
