// import 'dart:convert';

import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_catalog/model/cart_model.dart';
import 'package:flutter_catalog/model/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class CartCubit extends Cubit<List<CartModel>> {
  CartCubit() : super([]) {
    getPrefs();
  }

  void addToCart(ProductsModel product, int quantity) {
    print(state);
    bool isExist = state.any((element) => element.product?.id == product.id);
    if (isExist) return;

    CartModel newCartItem = CartModel(
      product: product,
      quantity: quantity,
    );
    state.add(newCartItem);

    emit(List.of(state));
  }

  void cartUpdate(ProductsModel product, int quantity) {
    bool isExist = state.any((element) => element.product?.id == product.id);
    if (isExist) {
      removeFromCart(product);
    }
    CartModel newCartItem = CartModel(
      product: product,
      quantity: quantity,
    );
    state.add(newCartItem);

    emit(List.of(state));
  }

  void removeFromCart(
    ProductsModel product,
  ) {
    CartModel foundProduct =
        state.firstWhere((element) => element.product?.id == product.id);

    state.remove(foundProduct);

    emit(List.of(state));
    setPrefs();
  }

  bool contains(
    ProductsModel product,
  ) {
    if (state.isNotEmpty) {
      final isExist = state.any((element) => element.product?.id == product.id);
      if (isExist) return true;
    }

    return false;
  }

  void setPrefs() async {
    final mapCart = state.map((p) => p.toJson()).toList();
    //print('mapcart${mapCart}');
    final jsonCart = jsonEncode(mapCart);
    //  print('${jsonCart.runtimeType} json');

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('cart', jsonCart);
  }

  void getPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    //await preferences.clear();
    //final prefs = await SharedPreferences.getInstance();

    final mapCart = preferences.getString('cart');
    final decodedCart = jsonDecode(mapCart!) as List;
    final data = decodedCart.map((json) => CartModel.fromJson(json)).toList();
    emit(List.of(data));
    //print('${decodedCart.runtimeType} >>json');
  }
  //  num total() {
  //   // int n = widget.cartList.length;
  //   // num total = 0;
  //   // for (int i = 0; i < n; i++) {
  //   //   total = total + widget.cartList[i].price;
  //   // }
  //   return state.fold(
  //       0 as num, (pre, ele) => pre + (ele.product!.price! * ele.quantity!));
  // }
}
