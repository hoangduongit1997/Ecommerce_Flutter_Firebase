import 'package:e_commerce_app/business_logic/entities/category.dart';
import 'package:e_commerce_app/business_logic/entities/product.dart';
import 'package:equatable/equatable.dart';

class AllProductsState extends Equatable {
  @override
  List<Object> get props => [];
}

/// Categories Loading
class CategoriesLoading extends AllProductsState {}

/// Adready categories data
class CategoriesLoaded extends AllProductsState {
  final List<Category> categories;
  final int selectedCategoryIndex;

  CategoriesLoaded({this.categories, this.selectedCategoryIndex});

  @override
  List<Object> get props => [categories];

  @override
  String toString() {
    return 'CategoriesLoaded{response: ${categories.length}}';
  }
}

/// Failure
class CategoriesLoadFailure extends AllProductsState {
  final String error;

  CategoriesLoadFailure(this.error);

  @override
  String toString() {
    return 'HomeLoadFailure{e: $error}';
  }
}

/// Display list products
class DisplayListProducts extends AllProductsState {
  final List<Product> productsByCategory;
  final bool loading;
  final String msg;

  DisplayListProducts({this.productsByCategory, this.loading, this.msg});

  factory DisplayListProducts.loading() {
    return DisplayListProducts(
      msg: "",
      productsByCategory: [],
      loading: true,
    );
  }

  factory DisplayListProducts.data(List<Product> productsByCategory) {
    return DisplayListProducts(
      msg: "",
      productsByCategory: productsByCategory,
      loading: false,
    );
  }

  factory DisplayListProducts.error(String msg) {
    return DisplayListProducts(
      msg: msg,
      productsByCategory: [],
      loading: false,
    );
  }

  @override
  List<Object> get props => [productsByCategory, loading, msg];

  @override
  String toString() {
    return 'DisplayListProducts{productsByCategory: ${productsByCategory.length}, loading: $loading, msg: $msg}';
  }
}