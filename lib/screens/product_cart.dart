import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_catalog/model/cart_model.dart';

import 'package:flutter_catalog/repository/cartCubit/cart_cubit.dart';
import 'package:flutter_catalog/service/calculations.dart';
import 'package:input_quantity/input_quantity.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<CartCubit, List<CartModel>>(
          builder: (context, state) {
            if (state.isEmpty) {
              return const Text("No items Added yet");
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: state.length,
                    itemBuilder: (context, index) {
                      CartModel cartItem = state[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Image.network(cartItem.product!.images![0]),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${cartItem.product!.category!.name}",
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey),
                            ),
                            Text("${cartItem.product!.title}"),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            Text("Total: \$ ${cartItem.product!.price}"),
                            IconButton(
                                onPressed: () {
                                  BlocProvider.of<CartCubit>(context)
                                      .removeFromCart(cartItem.product!);
                                },
                                icon: const Icon(CupertinoIcons.delete))
                          ],
                        ),
                        trailing: InputQty(
                          initVal: cartItem.quantity!,
                          maxVal: 99,
                          minVal: 1,
                          qtyFormProps: const QtyFormProps(enableTyping: false),
                          onQtyChanged: (value) {
                            cartItem.quantity = value.toInt();
                            BlocProvider.of<CartCubit>(context).cartUpdate(
                              cartItem.product!,
                              value.toInt(),
                            );
                          },
                          decoration: const QtyDecorationProps(
                              width: 14,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              qtyStyle: QtyStyle.classic),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  height: 70,
                  decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(14)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total: \$${Calculations.cartTotal(state)}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      CupertinoButton(
                          color: Theme.of(context).colorScheme.onBackground,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: const Text("Place Order"),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'this service temprory unavailable')));
                          })
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
