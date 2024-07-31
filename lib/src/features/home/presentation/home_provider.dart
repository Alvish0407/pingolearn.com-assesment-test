import 'dart:collection';

import 'package:flutter/material.dart';

import '../data/remote_home_repository.dart';
import '../domain/product_model.dart';

class HomeProvider extends ChangeNotifier {
  final RemoteHomeRepository repository;
  HomeProvider(this.repository);

  final List<Product> _products = [];
  List<Product> get products => UnmodifiableListView(_products);

  Future<void> getProducts() async {
    _products.clear();
    _products.addAll(await repository.getProducts());
    notifyListeners();
  }
}
