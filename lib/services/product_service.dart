import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/models/product.dart';
import 'package:riverpod_test/repositories/product_repository.dart';

final productProvider = ChangeNotifierProvider((ref) {
  return ProductService();
});

final getProductProvider = FutureProvider.autoDispose((ref) {
  final productRepository = ref.read(productProvider);
  return productRepository.getProducts();
});

class ProductService extends ChangeNotifier {

  List<Product> products = [];

  late ProductRepository productRepository;
  ProductService(){
    productRepository = ProductRepository();
  }

  getProducts() async {
    print('aaaa');
    List<Product> products = await productRepository.getProducts();
    this.products.addAll(products);
    notifyListeners();
  }


}