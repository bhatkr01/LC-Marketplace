import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'product_card.dart';
import '../../data/api/product/product_api.dart';

class Home extends ConsumerWidget{
  @override
  Widget build(BuildContext context, ref){
    
    // final products=ref.watch(productDataProvider);
    final products=ref.watch(productsProvider);


    return products.when(
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
      data: (products){
        print(products);
                          return CustomScrollView(
                      primary: false,
  slivers: <Widget>[
    SliverPadding(
      padding: const EdgeInsets.all(20),
      sliver: SliverGrid.count(
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        childAspectRatio:MediaQuery.of(context).size.width<601? 0.6: 0.8,
        crossAxisCount: MediaQuery.of(context).size.width<601? 2: 3,
        children: <Widget>[
          for (int index=0; index<products.length; index++ )
          ProductCard(product:products[index]),
        ],
      ),
    ),
  ],
                    );
      }
    );
  }
}





