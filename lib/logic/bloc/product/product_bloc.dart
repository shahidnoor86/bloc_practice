import 'package:bloc/bloc.dart';
import 'package:bloc_practice/data/models/product_model.dart';
import 'package:bloc_practice/data/repository/product_repository.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {

  }
}
