import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/product/product.dart';
import '../../../keys/keys.dart';

final dioProvider = Provider <Dio> ((ref){
  return Dio(BaseOptions(
    baseUrl:KeyConfig.BASE_URL,
  )
  );
}
);


final productsProvider = FutureProvider <List<Product>> ((ref) async {
  final dio=ref.watch(dioProvider);
  final response = await dio.get('products/');
  if (response.statusCode==200) {
    final data =response.data;
    return data.map<Product>((eachitem) => Product.fromJson(eachitem)).toList();
  }
  else{
    throw Exception('Failed to load product');
  }

}
);

//product service
// class ProductService{
//   late final Dio _dio =Dio(BaseOptions(
//     baseUrl:KeyConfig.BASE_URL,
//   )
//   );



//   Future <List<Product>> fetchProducts() async {
//     final response = await _dio.get('products/');
//     if (response.statusCode==200) {
//       final data =response.data;
//       return data.map<Product>((eachitem) => Product.fromJson(eachitem)).toList();
//     }
//     else{
//       throw Exception('Failed to load product');
//     }

//   }


// }

// final productApiProvider = Provider <ProductService>((ref)=> ProductService());


// //product provider
// final productDataProvider=FutureProvider<List<Product>>((ref) async {
//   return ref.read(productApiProvider).fetchProducts();
// }
// );


//   // late final Dio dio =Dio(BaseOptions(
//   //   baseUrl:KeyConfig.BASE_URL,
//   // )
//   // );

//   // Future <List<Product>> fetchProducts() async {
//   //   final response = await dio.get('products/');
//   //   if (response.statusCode==200) {
//   //     // print(response.data.map<Product>((eachitem) => Product.fromJson(eachitem)).toList());
//   //     // print(data);
//   //     return response.data.map<Product>((eachitem) => Product.fromJson(eachitem)).toList();
//   //   }
//   //   else{
//   //     throw Exception('Failed to load product');
//   //   }

//   // }

