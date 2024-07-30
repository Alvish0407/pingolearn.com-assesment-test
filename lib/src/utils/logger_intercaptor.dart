import 'dart:developer';

import 'package:dio/dio.dart';

class LoggerInterceptor implements Interceptor {
  final Map<String, Stopwatch> stopwatches = <String, Stopwatch>{};

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final String url = '${options.baseUrl}${options.path}';
    stopwatches[url] = Stopwatch()..start();
    log('\x1B[34m🟡 Making request: $url\x1B[0m');
    if (options.queryParameters.isNotEmpty) {
      log('\x1B[34mQuery params: ${options.queryParameters}\x1B[0m');
    }
    if (options.data != null) {
      log('\x1B[34mData: ${options.data}\x1B[0m');
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    final String url = '${response.requestOptions.baseUrl}${response.requestOptions.path}';
    _logMessageAndClearStopwatch(response.statusCode, url, '⬅️ Received response');
    log('\x1B[34m✅ Response: ${response.data}\x1B[0m');
    log('\x1B[34m-------------------------\x1B[0m');
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final String url = err.requestOptions.uri.toString();
    _logMessageAndClearStopwatch(err.response?.statusCode, url, '❌ Received error');
    if (err.response?.data != null) {
      log('\x1B[34m❌ Response Error: ${err.response?.data}\x1B[0m');
    }
    return handler.next(err);
  }

  void _logMessageAndClearStopwatch(int? statusCode, String url, String message) {
    final Stopwatch? stopwatch = stopwatches[url];
    if (stopwatch != null) {
      stopwatch.stop();
      _logResponse(statusCode, stopwatch.elapsedMilliseconds, url);
      stopwatches.remove(url);
    } else {
      log("\x1B[34m$message\x1B[0m");
    }
  }

  void _logResponse(int? statusCode, int milliseconds, String url) {
    final String emoji = switch (statusCode) {
      != null && >= 200 && < 300 => '🟢',
      != null && >= 300 && < 400 => '🟠',
      _ => '🔴'
    };
    if (statusCode != null) {
      log('\x1B[34m$emoji $statusCode $emoji | ${milliseconds}ms | $url\x1B[0m');
    } else {
      log('\x1B[34m$emoji | ${milliseconds}ms | $url\x1B[0m');
    }
  }
}
