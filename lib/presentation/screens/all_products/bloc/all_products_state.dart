import 'package:e_commerce_app/business_logic/entities/category.dart';
import 'package:e_commerce_app/business_logic/entities/product.dart';
import 'package:e_commerce_app/presentation/screens/all_products/bloc/all_products_bloc.dart';
import 'package:equatable/equatable.dart';

class AllProductsState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Categories Loading
class CategoriesLoading extends AllProductsState {}

/// Adready categories data
class CategoriesLoaded extends AllProductsState {
  final List<Category> categories;
  final int selectedCategoryIndex;

  CategoriesLoaded({
    required this.categories,
    required this.selectedCategoryIndex,
  });

  @override
  List<Object?> get props => [categories, selectedCategoryIndex];

  @override
  String toString() {
    return 'CategoriesLoaded{categories: $categories, selectedCategoryIndex:$selectedCategoryIndex}';
  }
}

/// Failure
class CategoriesLoadFailure extends AllProductsState {
  final String error;

  CategoriesLoadFailure(this.error);

  @override
  List<Object?> get props => [error];

  @override
  String toString() {
    return 'HomeLoadFailure{error: $error}';
  }
}

/// Display list products
class DisplayListProducts extends AllProductsState {
  final List<Product>? products;
  final bool? loading;
  final String? msg;

  DisplayListProducts({this.products, this.loading, this.msg});

  factory DisplayListProducts.loading() {
    return DisplayListProducts(
      msg: "",
      products: [],
      loading: true,
    );
  }

  factory DisplayListProducts.data(List<Product> products) {
    return DisplayListProducts(
      msg: "",
      products: products,
      loading: false,
    );
  }

  factory DisplayListProducts.error(String msg) {
    return DisplayListProducts(
      msg: msg,
      products: [],
      loading: false,
    );
  }

  @override
  List<Object?> get props => [products, loading, msg];

  @override
  String toString() {
    return 'DisplayListProducts{products: ${products!.length}, loading: $loading, msg: $msg}';
  }
}

/// Update toolbar
class UpdateToolbarState extends AllProductsState {
  final bool showSearchField;

  UpdateToolbarState({required this.showSearchField});

  @override
  List<Object?> get props => [showSearchField];

  @override
  String toString() {
    return 'UpdateSearchIconState{showSearchIcon: $showSearchField}';
  }
}

/// Open sort option dialog
class OpenSortOption extends AllProductsState {
  final bool isOpen;
  final ProductSortOption currSortOption;

  OpenSortOption({required this.isOpen, required this.currSortOption});

  @override
  List<Object?> get props =>
      [isOpen, currSortOption, DateTime.now().millisecond];

  @override
  String toString() {
    return 'OpenSortOption{isOpen: $isOpen, showSortBy: ${currSortOption.toString()}}';
  }
}