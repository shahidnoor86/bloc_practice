part of 'product_bloc.dart';

@immutable
sealed class ProductState {
  final List<Product>? products;

  const ProductState({this.products});
}

final class ProductInitial extends ProductState {
  ProductInitial() : super(products: []);
}
