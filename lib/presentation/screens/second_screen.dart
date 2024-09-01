import 'package:bloc_practice/data/models/product_model.dart';
import 'package:bloc_practice/logic/bloc/counter/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key, required this.title, required this.color});

  final String title;
  final Color color;

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<CounterBloc>().add(GetProducts());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
          child: BlocConsumer<CounterBloc, CounterState>(
        listener: (context, state) {},
        builder: (context, state) {
          debugPrint("SHAHID @@@@ ${state.products?.length.toString()}");
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                CardList(
                  listData: state.products ?? [],
                )
                /*ListView.builder(
                  itemCount: state.products?.length,
                  itemBuilder: (BuildContext context, int index) {
                    Product? item = state.products?[index];
                    return ListTile(
                      title: Text(item?.title ?? ""),
                    );
                  },
                ),*/
                /*ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.products?.length,
                    itemBuilder: (context, index) {
                      Product? prod = state.products?[index];
                      return SizedBox(
                        width: double.infinity,
                        child: Card(
                          // margin: EdgeInsets.all(2.0),
                          color: Colors.deepPurple,
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              children: [
                                Text(
                                  prod?.title ?? "",
                                  style: TextStyle(
                                      color: Colors.white,
                                      overflow: TextOverflow.clip),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),*/
                /*for (final Product? prod in state.products ?? [])
                        Card(
                            color: Colors.deepPurple,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    prod?.title ?? "",
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ))*/
              ],
            ),
          );
        },
      )),
    );
  }
}

class CardList extends StatelessWidget {
  final List<Product> listData;

  CardList({required this.listData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          itemCount: listData.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            Product prod = listData[index];
            double prodFinalPrice =
                prod.price! - (prod.price! * prod.discountPercentage / 100);
            return ListTile(
                title: Card(
              margin: EdgeInsets.all(0),
              color: Colors.blueGrey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Image.network(prod.thumbnail ?? "", width: 200),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      prod.title ?? "",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: const TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$${prod.price.toString() ?? ""}",
                          style: const TextStyle(
                              color: Colors.lime,
                              fontSize: 22,
                              decoration: TextDecoration.lineThrough),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "\$${prodFinalPrice.toStringAsFixed(2) ?? ""}",
                          style: const TextStyle(
                              color: Colors.cyanAccent,
                              fontSize: 22,
                              fontWeight: FontWeight.w900),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${prod.discountPercentage.toString() ?? ""} % off",
                          style: const TextStyle(
                              color: Colors.amber, fontSize: 20),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
          },
        ),
      ],
    );
  }
}
