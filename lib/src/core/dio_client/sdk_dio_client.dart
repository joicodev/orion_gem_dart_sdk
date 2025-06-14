import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:orion_gem_dart_sdk/orion_gem_dart_sdk.dart';
import 'package:orion_gem_nest_dart_client/orion_gem_nest_dart_client.dart';

enum StreamApiClientMethod { get, post }

class SdkDioClient {
  late final OrionGemNestDartClient _orionGemApiClient;

  SdkDioClient(String basePath, {String? geminiHost}) {
    _orionGemApiClient = OrionGemNestDartClient(
      dio: _dioInstance(geminiHost ?? basePath),
    );
  }

  OrionGemNestDartClient get instance => _orionGemApiClient;

  Dio _dioInstance(String host) {
    final dio = Dio();
    dio.interceptors.add(TokenInterceptor(dio));
    dio.interceptors.add(ClientLogInterceptor());

    dio.options.baseUrl = host;
    return dio;
  }

  // void clearTokens() => _secureStorage.clearTokens();

  Future<Response<ResponseBody>> streamApiCall<T>({
    required String path,
    Object? body,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    String method = 'POST',
  }) async {
    final options = Options(
      headers: {
        "Accept": "text/event-stream",
        "Cache-Control": "no-cache",
        ...?headers,
      },
      method: method.toUpperCase(),
      extra: {'secure': <Map<String, String>>[], ...?extra},
      validateStatus: validateStatus,
      responseType: ResponseType.stream,
    );

    final dio = _orionGemApiClient.dio;
    final response = await dio.request<ResponseBody>(
      path,
      data: body,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    return response;
  }

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
