import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/product/product.dart';
import '../config/dio_config.dart';



// code to fetch data with futureprovider; just fetches once; does not update

// final productsProvider = FutureProvider <List<Product>> ((ref) async {
//   final dio=ref.watch(dioProvider);
//   final response = await dio.get('products/');
//   if (response.statusCode==200) {
//     final data =response.data;
//     return data.map<Product>((eachitem) => Product.fromJson(eachitem)).toList();
//   }
//   else{
//     throw Exception('Failed to load product');
//   }

// }
// );

//statenotifier to perform repeated fetching

final productsProvider =StateNotifierProvider<ProductNotifier, AsyncValue>((ref){
  return ProductNotifier(ref);

});

class ProductNotifier extends StateNotifier<AsyncValue>{
  ProductNotifier(this.ref):super(const AsyncValue.loading()){
    fetchProductsWithDelay(const Duration(seconds: 15));
  }

final Ref ref;

  Future <void> fetchProductsWithDelay(Duration delay) async {
    while (true){
      try{
  final dio=ref.watch(dioProvider);
  final response = await dio.get('products/');
    if (response.statusCode==200) {
      final data =response.data;
      state=AsyncValue.data(data.map<Product>((eachitem) => Product.fromJson(eachitem)).toList());
      // return data.map<Product>((eachitem) => Product.fromJson(eachitem)).toList();
    }
    else{
      throw Exception('Failed to load product');
    } 

      }catch(e){
        state=AsyncValue.error(e,StackTrace.current);
      }
      
    await Future.delayed(delay);

    }

  }


// }

}

//extra code

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

