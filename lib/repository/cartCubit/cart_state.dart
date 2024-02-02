import 'package:flutter_catalog/model/product_model.dart';

abstract class CartState {
  final List<ProductsModel> cartItem;
  CartState(this.cartItem);
}

class CartInitialState extends CartState {
  CartInitialState() : super([]);
}

class CartLoadingsState extends CartState {
  CartLoadingsState(super.cartItem);
}

class CartLoadedState extends CartState {
  CartLoadedState(super.cartItem);
}

class CartErrorState extends CartState {
  final String message;
  CartErrorState(super.cartItem, this.message);
}
