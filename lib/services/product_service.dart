import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/models/product.dart';
import 'package:riverpod_test/repositories/product_repository.dart';

final productProvider = ChangeNotifierProvider.family((ref, BuildContext context) {
  return ProductService(context);
});

final getProductProvider = FutureProvider.autoDispose.family((ref, BuildContext context) {
  final productRepository = ref.read(productProvider(context));
  return productRepository.getProducts();
});

class ProductService extends ChangeNotifier {

  List<Product> products = [];

  late ProductRepository productRepository;
  ProductService(BuildContext context){
    productRepository = ProductRepository(context);
  }

  getProducts() async {
    print('aaaa');
    List<Product> products = await productRepository.getProducts();
    this.products.addAll(products);
    notifyListeners();
  }


}