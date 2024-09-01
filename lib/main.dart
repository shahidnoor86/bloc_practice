import 'package:bloc_practice/logic/bloc/counter/counter_bloc.dart';
import 'package:bloc_practice/logic/cubit/counter_cubit.dart';
import 'package:bloc_practice/logic/cubit/counter_state.dart';
import 'package:bloc_practice/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      create: (BuildContext context) => CounterBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
          useMaterial3: true,
        ),
        home: const HomeScreen(
          title: 'Flutter Demo Home Page',
          color: Colors.blue,
        ),
      ),
    );
  }
}
