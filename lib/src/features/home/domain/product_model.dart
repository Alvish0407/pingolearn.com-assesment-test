import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utils/json_convertors.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class Product with _$Product {
  const factory Product({
    required int id,
    required double price,
    required String category,
    required String description,
    @UriConverter() Uri? thumbnail,
    required double discountPercentage,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}
