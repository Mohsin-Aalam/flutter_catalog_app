import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_catalog/core/routes.dart';
import 'package:flutter_catalog/model/cart_model.dart';
import 'package:flutter_catalog/repository/cartCubit/cart_cubit.dart';

import 'package:flutter_catalog/repository/cubit/product_state.dart';
import 'package:flutter_catalog/repository/cubit/pruduct_cubit.dart';
import 'package:flutter_catalog/screens/product_detail.dart';
import 'package:flutter_catalog/widgets/my_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Catalog App"),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 24),
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, MyRoutes.cartScreen);
                },
                icon: BlocBuilder<CartCubit, List<CartModel>>(
                  builder: (context, state) {
                    return Badge(
                      label: Text("${state.length}"),
                      child: Icon(CupertinoIcons.cart),
                    );
                  },
                ),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductLoadingsState) {
              return const CircularProgressIndicator();
            }
            if (state is ProductErrorState) {
              return Text(state.message);
            }
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 6,
                  mainAxisExtent: 300),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: state.product.length,
              itemBuilder: (context, index) {
                final product = state.product[index];
                return Card(
                  child: Hero(
                      tag: Key(product.id!.toString()),
                      child: Material(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDetailScreen(product: product),
                                ));
                          },
                          child: GridTile(
                            footer: Container(
                                color: Colors.white70,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.title!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                          "Price: \$ ${product.price.toString()}"),
                                    ],
                                  ),
                                )),
                            child: Image.network(
                              product.images![0],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )),
                );
                // return InkWell(
                //   onTap: () {},
                //   child: Container(
                //     decoration: BoxDecoration(color: Colors.grey),
                //     child: Column(
                //       children: [Image.network("${product.images?[0]}"),

                //       ],
                //     ),
                //   ),
                // );
              },
            );
          },
        ),
      ),
      drawer: const MyDrawer(),
    );
  }
}
