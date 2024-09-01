part of 'counter_bloc.dart';

@immutable
abstract class CounterEvent {}

class IncrementCounter extends CounterEvent {}

class DecrementCounter extends CounterEvent {}

class FastIncrement extends CounterEvent {}

class FastDecrement extends CounterEvent {}

class GetProducts extends CounterEvent {}
