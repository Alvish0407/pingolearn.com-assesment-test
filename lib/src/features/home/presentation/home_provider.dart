import 'dart:collection';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

import '../data/remote_home_repository.dart';
import '../domain/product_model.dart';

class HomeProvider extends ChangeNotifier {
  final RemoteHomeRepository repository;
  HomeProvider(this.repository);

  bool get showDiscountedPrice => FirebaseRemoteConfig.instance.getBool('showDiscountedPrice');

  final List<Product> _products = [];
  List<Product> get products => UnmodifiableListView(_products);

  Future<void> getProducts() async {
    _products.clear();
    await FirebaseRemoteConfig.instance.fetchAndActivate();
    _products.addAll(await repository.getProducts());
    notifyListeners();
  }
}
