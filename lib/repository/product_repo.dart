import 'dart:convert';

import 'package:flutter_catalog/model/product_model.dart';
import 'package:http/http.dart' as http;

class ProductRepo {
  Future<List<ProductsModel>> fetchAllProducts() async {
    // print("hello");
    String url = "https://api.escuelajs.co/api/v1/products?offset=&limit=20";
    try {
      final response = await http.get(Uri.parse(url));
      final List<dynamic> product = jsonDecode(response.body);

      // print(product);
      return product
          .map((products) => ProductsModel.fromJson(products))
          .toList();
    } catch (err) {
      rethrow;
    }
  }
}
