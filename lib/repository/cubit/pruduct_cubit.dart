import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_catalog/repository/cubit/product_state.dart';
import 'package:flutter_catalog/repository/product_repo.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitialState()) {
    // print("hello");
    _initialize();
  }
  final _productRepo = ProductRepo();

  void _initialize() async {
    emit(ProductLoadingsState(state.product));
    try {
      log("hello world");

      final products = await _productRepo.fetchAllProducts();
      emit(ProductLoadedState(products));
    } catch (ex) {
      emit(ProductErrorState(state.product, ex.toString()));
    }
  }
}
