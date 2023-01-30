import 'dart:async';

import 'package:flutter/material.dart';
import '../data/models/product/product.dart';
import '../data/api/product/product_api.dart';



Future<List<Product>> fetchP() async{
  final data=await fetchProducts();
  return data.map<Product>((eachitem) => Product.fromJson(eachitem)).toList();
}




class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  void initState() {
    super.initState();
    // futureProduct=fetchP();
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      // future: futureProduct,
      future: fetchP(),
      builder: ((context, snapshot) {
       if (snapshot.hasData) {
        var allproducts=snapshot.data!;
        return ListView.builder(
          itemCount: allproducts.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(allproducts[index].productName)
            );
          }
          );
       }
       else if (snapshot.hasError){
        return Text('${snapshot.error}');
       }
       
       return const CircularProgressIndicator();
      })
    );

  }
}