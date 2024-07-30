import 'package:dio/dio.dart';

import '../utils/logger_intercaptor.dart';

String get baseUrl => 'https://dummyjson.com';

class ApiClient {
  static final BaseOptions _defaultOptions = BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 10),
  );

  final Dio httpClient;

  static final interceptors = [LoggerInterceptor()];

  /// Creates an [ApiClient] with default options.
  ApiClient() : httpClient = Dio(_defaultOptions)..interceptors.addAll(interceptors);

  @override
  String toString() {
    return "ApiClient(_httpClient.options.headers['Authorization']: ${httpClient.options.headers['Authorization']})";
  }
}
