import 'package:flutter_catalog/model/product_model.dart';

class CartModel {
  int? quantity;

  ProductsModel? product;

  CartModel({
    this.quantity,
    this.product,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      product: ProductsModel.fromJson(json['product']),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'quantity': quantity, 'product': product!.toJson()};
  }
}
