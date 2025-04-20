part of '../client_library.dart';

/// Interceptor for logging HTTP requests and responses.
class ClientLogInterceptor extends Interceptor {
  late int startTime;
  late int endTime;

  /// Method to be called before sending the HTTP request.
  ///
  /// @param options: The options for the HTTP request [RequestOptions].
  /// @param handler: The request interceptor handler [RequestInterceptorHandler].
  ///
  /// @returns: Nothing.
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    startTime = DateTime.now().millisecondsSinceEpoch;
    log("-----------------------------------------");
    log("HOST: ${options.baseUrl}");
    log("PATH: ${options.path}");
    log("METHOD: ${options.method}");
    log("HEADERS: ${options.headers}");

    if (options.data != null) {
      log("REQUEST BODY: ${options.data}");
    }

    if (options.data is FormData) {
      log("FORMAT fields:${(options.data as FormData).fields}");
      log("FORMAT files:${(options.data as FormData).files}");
    }

    if (options.queryParameters.isNotEmpty) {
      log("QUERY PARAMS: ${options.queryParameters}");
    }

    return super.onRequest(options, handler);
  }

  /// Method to be called after receiving the HTTP response.
  ///
  /// @param response: The HTTP response [Response].
  /// @param handler: The response interceptor handler [ResponseInterceptorHandler].
  ///
  /// @returns: Nothing.
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    endTime = DateTime.now().millisecondsSinceEpoch;
    final ms = endTime - startTime;
    log('\n');
    log("STATUS CODE: ${response.statusCode}");
    try {
      log('RESPONSE ${json.encode(response.data)}');
    } catch (_) {
      log('RESPONSE ${response.data}');
    }

    log("TIME: $ms ms ~> (${ms / 1000} seconds)");
    log("PATH: ${response.realUri.path}");
    log("-----------------------------------------");
    return super.onResponse(response, handler);
  }

  /// Method to be called in case of error in the HTTP request.
  ///
  /// @param err: The Dio error [DioException].
  /// @param handler: The error interceptor handler [ErrorInterceptorHandler].
  ///
  /// @returns: Nothing.
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    endTime = DateTime.now().millisecondsSinceEpoch;
    log("------------------ERROR-------------------");
    log("PATH: ${err.response?.realUri.path}");
    log("ERROR STATUS CODE: ${err.response?.statusCode}");
    log("ERROR TYPE: ${err.type}");
    log("ERROR RESPONSE: ${err.response?.data}");
    log("TIME: ${endTime - startTime} ms");
    log("-----------------------------------------");
    super.onError(err, handler);
  }
}
