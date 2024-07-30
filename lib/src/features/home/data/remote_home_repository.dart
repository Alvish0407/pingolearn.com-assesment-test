import 'package:dio/dio.dart';

import '../../../services/api_client.dart';
import '../../../services/exception_handler.dart';
import '../domain/product_model.dart';

class RemoteHomeRepository with ExceptionHandlerMixin {
  @override
  Future<List<Product>> getCategories({CancelToken? cancelToken}) async {
    return handleException<List<Product>>(() async {
      final response = await ApiClient().httpClient.get(
            '/products',
            cancelToken: cancelToken,
          );

      return (response.data['data'] as List).map<Product>((e) => Product.fromJson(e)).toList();
    });
  }
}
