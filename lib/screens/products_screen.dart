import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/services/product_service.dart';

import '../models/product.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        backgroundColor: Colors.purple,
      ),
      body: Consumer(
          builder: (_, ref, __){
            final getProducts = ref.watch(getProductProvider(context));
            return RefreshIndicator(
              onRefresh: () async {
                await ref.refresh(getProductProvider(context).future);
              },
              child: getProducts.when(
                loading: () => const CircularProgressIndicator(),
                error: (err, stack) => Text('Error: $err'),
                data: (_) {
                  final products = ref.watch(productProvider(context)).products;
                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (_, index){
                      Product product = products[index];
                      return Text('${product.brand} -- $index');
                    },
                  );
                },
              ),
            );
          },
        ),
      floatingActionButton: Consumer(
        builder: (_, ref, __){
          return FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              ref.read(productProvider(context).notifier).getProducts();
            },
          );
        },
      ),
    );
  }
}
