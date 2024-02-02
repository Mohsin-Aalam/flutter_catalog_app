import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_catalog/core/routes.dart';
import 'package:flutter_catalog/repository/cartCubit/cart_cubit.dart';
import 'package:flutter_catalog/repository/cubit/pruduct_cubit.dart';
import 'package:flutter_catalog/screens/auth/login_screen.dart';
import 'package:flutter_catalog/screens/home_page.dart';
import 'package:flutter_catalog/screens/product_cart.dart';

import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductCubit(),
        ),
        BlocProvider(
          create: (context) => CartCubit(),
        )
      ],
      child: MaterialApp(
        themeMode: ThemeMode.system,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: GoogleFonts.abrilFatface().fontFamily,
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: GoogleFonts.abrilFatface().fontFamily,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: MyRoutes.homeRoute,
        routes: {
          "/": (context) => const LoginScreen(),
          MyRoutes.homeRoute: (context) => const HomeScreen(),
          MyRoutes.loginRoute: (context) => const LoginScreen(),
          MyRoutes.cartScreen: (context) => const CartScreen(),
        },
      ),
    );
  }
}
