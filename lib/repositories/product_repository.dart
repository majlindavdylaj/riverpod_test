import 'package:flutter/cupertino.dart';
import 'package:riverpod_test/api/api.dart';
import 'package:riverpod_test/api/rest_api.dart';
import 'package:riverpod_test/models/product.dart';

class ProductRepository extends RestApi {

  ProductRepository(BuildContext context) : super(context: context);

  Future<List<Product>> getProducts() async {
    final response = await super.makeGetRequest('${Api.host}/products');
    final List list = response['products'].map((e) => Product.fromJson(e)).toList();
    final List<Product> products = list.cast<Product>();
    return products;
  }

}