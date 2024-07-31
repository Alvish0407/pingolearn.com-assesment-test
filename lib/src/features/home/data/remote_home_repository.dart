import 'package:dio/dio.dart';

import '../../../services/api_client.dart';
import '../../../services/exception_handler.dart';
import '../domain/product_model.dart';

class RemoteHomeRepository with ExceptionHandlerMixin {
  final ApiClient apiClient;
  RemoteHomeRepository({required this.apiClient});

  Future<List<Product>> getProducts({CancelToken? cancelToken}) async {
    return handleException<List<Product>>(() async {
      final response = await apiClient.httpClient.get(
        '/products',
        cancelToken: cancelToken,
      );

      return (response.data['products'] as List).map<Product>((e) => Product.fromJson(e)).toList();
    });
  }
}
