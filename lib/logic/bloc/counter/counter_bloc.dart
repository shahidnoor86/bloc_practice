import 'package:bloc/bloc.dart';
import 'package:bloc_practice/data/models/product_model.dart';
import 'package:bloc_practice/data/repository/product_repository.dart';
import 'package:meta/meta.dart';

part 'counter_event.dart';

part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  static const _fastChangeConstant = 10;

  CounterBloc() : super(CounterInitial()) {
    on<IncrementCounter>(
        (event, emit) => emit(CounterState(count: (state.count ?? 0) + 1)));

    on<DecrementCounter>(
        (event, emit) => emit(CounterState(count: (state.count ?? 0) - 1)));

    on<FastIncrement>((event, emit) =>
        emit(CounterState(count: (state.count ?? 0) + _fastChangeConstant)));

    on<FastDecrement>((event, emit) =>
        emit(CounterState(count: (state.count ?? 0) - _fastChangeConstant)));

    /*on<GetProducts>((event, emit) =>
        emit(CounterState(count: (state.count ?? 0) - _fastChangeConstant)));*/

    on<GetProducts>((event, emit) async {
      final response = await ProductRepository().getProductList();
      // state.products = response.products;
      emit(CounterState(products: response.products));
    });
  }
}
