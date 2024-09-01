import 'package:bloc_practice/logic/bloc/counter/counter_bloc.dart';

// import 'package:bloc_practice/logic/bloc/product/product_bloc.dart';
// import 'package:bloc_practice/logic/cubit/counter_cubit.dart';
import 'package:bloc_practice/presentation/screens/second_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title, required this.color});

  final String title;
  final Color color;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            /*BlocConsumer<CounterCubit, CounterState>(
              listener: (context, state) {
                if (state.counterValue % 5 == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Multiple of 5"),
                    duration: Duration(milliseconds: 1000),
                  ));
                }
              },
              builder: (context, state) {
                return Text(
                  state.counterValue.toString(),
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),*/

            BlocBuilder<CounterBloc, CounterState>(builder: (context, state) {
              return Text(
                '${state.count}',
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              );
            }),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    // BlocProvider.of<CounterCubit>(context).increment();
                    context.read<CounterBloc>().add(FastDecrement());
                  },
                  tooltip: 'Increment',
                  child: const Icon(Icons.keyboard_double_arrow_left),
                ),
                FloatingActionButton(
                  onPressed: () {
                    // BlocProvider.of<CounterCubit>(context).decrement();
                    context.read<CounterBloc>().add(DecrementCounter());
                  },
                  tooltip: 'Decrement',
                  child: const Icon(Icons.remove),
                ),
                FloatingActionButton(
                  onPressed: () {
                    // BlocProvider.of<CounterCubit>(context).increment();
                    context.read<CounterBloc>().add(IncrementCounter());
                  },
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                ),
                FloatingActionButton(
                  onPressed: () {
                    // BlocProvider.of<CounterCubit>(context).increment();
                    context.read<CounterBloc>().add(FastIncrement());
                  },
                  tooltip: 'Increment',
                  child: const Icon(Icons.keyboard_double_arrow_right),
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            MaterialButton(
              color: widget.color,
              onPressed: () {
                // context.read<ProductBloc>().add(GetProducts());
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SecondScreen(
                        title: "Second Screen", color: Colors.redAccent)));
              },
              child: Text("Go to Second Screen"),
            ),
          ],
        ),
      ),
    );
  }
}
