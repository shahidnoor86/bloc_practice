part of 'counter_bloc.dart';

@immutable
class CounterState {
  final int? count;
  late List<Product>? products;

  CounterState({this.count, this.products});
}

final class CounterInitial extends CounterState {
  CounterInitial() : super(count: 0, products: []);
}
