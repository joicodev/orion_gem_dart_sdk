import 'dart:convert';
import 'dart:developer';
import 'package:ai_chat_dart_sdk/ai_chat_dart_sdk.dart';
import 'package:dio/dio.dart';
import 'package:gemini_dart_client/gemini_dart_client.dart';

class AIChatDioClient {
  late final GeminiDartClient _geminiDartClient;

  final SecureStorageRepository _secureStorage;

  AIChatDioClient(String basePath, this._secureStorage, {String? geminiHost}) {
    _geminiDartClient = GeminiDartClient(
      dio: _dioInstance(geminiHost ?? basePath),
    );
  }

  GeminiApi get geminiApi {
    return _geminiDartClient.getGeminiApi();
  }

  Dio _dioInstance(String host) {
    final dio = Dio();
    dio.interceptors.add(TokenInterceptor(dio));
    dio.interceptors.add(ClientLogInterceptor());

    dio.options.baseUrl = host;
    return dio;
  }

  void clearTokens() => _secureStorage.clearTokens();

  Future<Either<BaseException, R>> apiCall<R, T>({
    required Future<Response<T>> apiMethod,
    required R Function(T data) converter,
  }) async {
    try {
      final result = await apiMethod;

      try {
        final statusCode = result.statusCode ?? 0;
        log('TRY SERIALIZE TYPE [$T]');
        if (statusCode >= 200 && statusCode <= 201 && result.data != null) {
          return Right(converter(result.data as T));
        }

        return _handleAPIException(result);
      } on Error catch (_) {
        return Left(
          SerializingException(
            message: 'An error occurred while parsing the data',
            type: SerializingExceptionErrorType.serializeData,
          ),
        );
      }
    } on DioException catch (e) {
      print('DioException :::: $e');

      return Left(
        DIOException(message: e.message ?? 'Unknown error', type: e.type),
      );
    }
  }

  Either<BaseException, R> _handleAPIException<R>(Response<dynamic> result) {
    JSON jsonResult = {};
    final statusCode = result.statusCode;

    if (result.data != null) {
      if (result.data.runtimeType == String) {
        try {
          jsonResult = json.decode(result.data as String);
        } catch (e) {
          jsonResult = {'message': result.data, 'code': statusCode.toString()};
        }
      } else {
        jsonResult = result.data as JSON;
      }
    }

    String message = '';
    try {
      message = jsonResult['detail'];
    } catch (e) {
      log(
        'ERROR PARSING > [${result.requestOptions.path}]: THE DATA ~> ${result.data}',
      );
      log(
        'ERROR PARSING > [${result.requestOptions.path}]: ERROR PARSING DATA ~> $e',
      );
    }

    return Left(
      APIException(
        message: message,
        type: APIExceptionErrorType.valueOf(jsonResult['error'] ?? ""),
      ),
    );
  }
}
