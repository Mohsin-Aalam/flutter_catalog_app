import 'package:flutter_catalog/model/cart_model.dart';

class Calculations {
  static double cartTotal(List<CartModel> items) {
    double total = 0;
    for (int i = 0; i < items.length; i++) {
      total += items[i].product!.price! * items[i].quantity!;
    }
    return total;
  }
}
