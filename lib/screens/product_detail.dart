import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_catalog/model/cart_model.dart';
import 'package:flutter_catalog/model/product_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_catalog/repository/cartCubit/cart_cubit.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductsModel product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        margin: const EdgeInsets.all(16),
        height: 70,
        decoration: BoxDecoration(
            color: Colors.black26, borderRadius: BorderRadius.circular(14)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Price: \$${product.price.toString()}",
              style: const TextStyle(fontSize: 28),
            ),
            BlocBuilder<CartCubit, List<CartModel>>(
              builder: (context, state) {
                bool isInCart =
                    BlocProvider.of<CartCubit>(context).contains(product);
                return CupertinoButton(
                    color: (isInCart) ? Colors.grey : Colors.black87,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    onPressed: () {
                      if (isInCart) {
                        return;
                      }
                      BlocProvider.of<CartCubit>(context).addToCart(
                        product,
                        1,
                      );
                      BlocProvider.of<CartCubit>(context).setPrefs();
                    },
                    child: (isInCart)
                        ? const Text(
                            "Added To Cart",
                            style: TextStyle(color: Colors.grey),
                          )
                        : const Text("Add To Cart"));
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(product.title!),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              child: CarouselSlider.builder(
                  itemCount: product.images!.length,
                  itemBuilder: (context, index, realIndex) {
                    String url = product.images![index];
                    return Image.network(url);
                  },
                  options: CarouselOptions(
                      autoPlay: true, enlargeCenterPage: true, height: 400)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title!,
                  style: TextStyle(fontSize: 28),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  "Category:${product.category!.name!}",
                  style: TextStyle(fontSize: 18, color: Colors.black38),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  "Description:${product.description}",
                  style: TextStyle(fontSize: 18, color: Colors.black38),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
