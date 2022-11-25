import 'package:flutter/widgets.dart';
import 'package:test1/lucinka/product_model.dart';

import './dbprovider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final product = ProductModel(
    id: 1,
    title: 'Title 1',
    mj: 'ks',
    price: '80',
  );

  await ProductDbProvider.instance.addItem(product);
  var products = await ProductDbProvider.instance.fetchProducts();
  print(products[0].title); //Title 1

  final newProduct = ProductModel(
    id: product.id,
    title: 'Title 1 changed',
    mj: product.mj,
    price: product.price,
  );

  await ProductDbProvider.instance.updateProduct(product.id, newProduct);
  var updatedProducts = await ProductDbProvider.instance.fetchProducts();
  print(updatedProducts[0].title); //Title 1 changed

  await ProductDbProvider.instance.deleteProduct(product.id);
  print(await ProductDbProvider.instance.fetchProducts()); //[]
}
