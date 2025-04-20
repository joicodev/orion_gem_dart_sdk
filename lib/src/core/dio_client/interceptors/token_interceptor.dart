part of '../client_library.dart';

class TokenInterceptor extends Interceptor {
  // int retryConnection = 0;
  final Dio _dio;
  final SecureStorageRepository secureStorage = SecureStorageRepositoryImpl();
  final List<Map<dynamic, dynamic>> failedRequests = [];

  TokenInterceptor(this._dio);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final isSecure = _isSecure(options);
    if (isSecure) {
      final accessToken = await secureStorage.readAccessToken();
      if (accessToken != null) {
        options.headers[HttpHeaders.authorizationHeader] =
            "Bearer $accessToken";
      }
    }

    final headerLang = options.extra["Accept-Language"];
    if (headerLang != null && headerLang != "") {
      options.headers["Accept-Language"] = headerLang;
    }

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    handler.next(response);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    log(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    if (!_isSecure(err.requestOptions)) {
      return handler.next(err);
    }

    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    final refreshToken = await secureStorage.readRefreshToken();
    if (refreshToken == null) {
      return handler.next(err);
    }

    /* print('****************BEFORE REFRESH TOKEN****************');
    final resultRefreshToken = await _refreshToken(refreshToken);
    print('****************AFTER REFRESH TOKEN****************');

    if (resultRefreshToken == null || resultRefreshToken.access == null) {
      return handler.next(err);
    } */

    /*if(retryConnection > 3) {
      retryConnection = 0;
      print('RESOLVE HERE....');
      return handler.resolve(err.response!);
    }*/

    // retryConnection += 1;
    final retryResult = await _retryRequest(err.requestOptions);
    return handler.resolve(retryResult);
  }

  bool _isSecure(RequestOptions options) {
    return options.extra["isSecure"] ?? false;
  }

  /* Future<TokenRefreshOutputSchema?> _refreshToken(String refreshToken) async {
    try {
      final dio = Dio(_dio.options);
      dio.interceptors.add(ClientLogInterceptor());

      final getTokenApi = Profile(dio: dio).getTokenApi();
      final response = await getTokenApi.refreshToken(
        tokenRefreshInputSchema: TokenRefreshInputSchema(
          (b) => b..refresh = refreshToken,
        ),
      );

      print('*********** STATUS CODE ********** ${response.statusCode}');
      if (response.statusCode == 200 && response.data != null) {
        final accessToken = response.data!.access;
        if (accessToken != null) {
          await securePrefs.saveAccessToken(accessToken);
        }

        final refreshToken = response.data!.refresh;
        await securePrefs.saveRefreshToken(refreshToken);
      }

      return response.data;
    } catch (e, stackTrace) {
      debugPrint("GET NEW TOKEN FAIL: ${e.toString()}");
      debugPrintStack(label: e.toString(), stackTrace: stackTrace);
      return null;
    }
  } */

  Future<Response<dynamic>> _retryRequest(RequestOptions reqOptions) async {
    final options = Options(
      method: reqOptions.method,
      headers: reqOptions.headers,
    );

    return await _dio.request<dynamic>(
      options: options,
      reqOptions.path,
      data: reqOptions.data,
      queryParameters: reqOptions.queryParameters,
    );
  }
}
