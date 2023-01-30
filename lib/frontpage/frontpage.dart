import 'package:flutter/material.dart';
import 'product_card.dart';
import '../data/models/product/product.dart';
import '../data/api/product/product_api.dart';
import 'dart:async';


Future<List<Product>> fetchP() async{
  final data=await fetchProducts();
  return data.map<Product>((eachitem) => Product.fromJson(eachitem)).toList();
}

class FrontPage extends StatelessWidget{

  final product=Product(
    id:1,
    productName: 'lion',
    productPicture:'assets/images/lion.jpg',
    productDescription:"Lion's pictue", 
    productCondition: "USED-GOOD", 
    productAction: "SELL",
    productPrice: 13, 
    productDate:DateTime.parse("2000-05-15"),
    productAuthor:1,
  );
  var productList=[
Product(
    id:1,
    productName: 'lion',
    productPicture:'assets/images/lion.jpg',
    productDescription:"Lion's pictue", 
    productCondition: "USED-GOOD", 
    productAction: "SELL",
    productPrice: 13, 
    productDate:DateTime.parse("2000-05-15"),
    productAuthor:1,
  ),
Product(
    id:1,
    productName: 'doneky',
    productPicture:'assets/images/lion.jpg',
    productDescription:"Lion's pictue", 
    productCondition: "USED-GOOD", 
    productAction: "SELL",
    productPrice: 13, 
    productDate:DateTime.parse("2000-05-15"),
    productAuthor:1,
  ),
Product(
    id:1,
    productName: 'cat',
    productPicture:'assets/images/lion.jpg',
    productDescription:"Lion's pictue", 
    productCondition: "USED-GOOD", 
    productAction: "SELL",
    productPrice: 13, 
    productDate:DateTime.parse("2000-05-15"),
    productAuthor:1,
  ),
Product(
    id:1,
    productName: 'dog',
    productPicture:'assets/images/lion.jpg',
    productDescription:"Lion's pictue", 
    productCondition: "USED-GOOD", 
    productAction: "SELL",
    productPrice: 13, 
    productDate:DateTime.parse("2000-05-15"),
    productAuthor:1,
  ),


  ];

  @override
  Widget build(BuildContext context){
                  return FutureBuilder<List<Product>>(
                    future: fetchP(),
                    builder: ((context, snapshot){
                      // if (snapshot.hasData){
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
          for (int index=0; index<snapshot.data!.length; index++ )
         ProductCard(product:snapshot.data![index]),
         
        ],
      ),
    ),
  ],
                  );
                      }
                    // }
                    )
                    );
  }
}








//                   return CustomScrollView(
//                     slivers:[
//                       SliverToBoxAdapter(child:
//                   LayoutGrid(
//                       columnSizes:  MediaQuery.of(context).size.width<601? [1.fr, 1.fr]: [1.fr, 1.fr,1.fr],
//                       rowSizes :List.generate(10, (_) => auto),
//                       children: [
//                         GridPlacement(
//                           child: ProductCard(),
//                         ),
//                         GridPlacement(
//                           child: ProductCard(),
//                         ),
//                         GridPlacement(
//                           child: ProductCard(),
//                         ),
//                         GridPlacement(
//                           child: ProductCard(),
//                         ),
//                         GridPlacement(
//                           child: ProductCard(),
//                         ),
                        
//                       ],
//                     )
//                       )
//                       ]
//                       );
//   }

// } 