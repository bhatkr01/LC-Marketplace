import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/product/product.dart';
import '../config/dio_config.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import '../accounts/accounts_api.dart';
// import 'dart:io';

//statenotifier to perform repeated fetching

final productsProvider =
    StateNotifierProvider<ProductNotifier, AsyncValue>((ref) {
  return ProductNotifier(ref);
});

class ProductNotifier extends StateNotifier<AsyncValue> {
  ProductNotifier(this.ref) : super(const AsyncValue.loading()) {
    fetchProductsWithDelay(const Duration(seconds: 15));
  }

  final Ref ref;

  Future<void> fetchProductsWithDelay(Duration delay) async {
    while (true) {
      try {
        final dio = ref.watch(dioProvider);
        final response = await dio.get('products/');
        if (response.statusCode == 200) {
          final data = response.data;
          state = AsyncValue.data(data
              .map<Product>((eachitem) => Product.fromJson(eachitem))
              .toList());
          // return data.map<Product>((eachitem) => Product.fromJson(eachitem)).toList();
        } else {
          throw Exception('Failed to load product');
        }
      } catch (e) {
        state = AsyncValue.error(e, StackTrace.current);
      }

      await Future.delayed(delay);
    }
  }
}








class AddProductsStateNotifier extends StateNotifier<Map<String,dynamic>> {
  final Ref ref;
  String token = '';
  AddProductsStateNotifier(this.ref):super({});
  Future <void> addProducts(body) async{
    getToken("access").then((value) => {
          token = value ?? ''
        });
        // print(token);
    final dio= ref.watch(dioProvider);
    final response = await dio.post(
      'products/',
      options: Options(
        headers: {
          // Headers.contentTypeHeader: 'application/json',
          'authorization': 'JWT $token',
        }
      ),
      // data: jsonEncode(body),
      data: body,
      );
    if (response.statusCode==201) {
      return response.data;
    }
    else{
      throw Exception('Product Upload Failed');
    }

  }


}


final addProductsProvider = StateNotifierProvider<AddProductsStateNotifier, Map<String,dynamic>>((ref) {

return AddProductsStateNotifier(ref);
}
);






                          // print("hi2$dataInput");
                          // print("hi2$formData");
                          // Dio dio = Dio();

                          // getToken("access").then((value) {
                          //   setState(() {
                          //     token = value ?? '';
                          //   });
                          // });
                          // print('heyaaaa$token');

                          // dio
                          //     .post("http://10.0.0.180:8000/api/products/",
                          //         options: Options(headers: {
                          //           // Headers.contentTypeHeader: 'application/json',
                          //           'authorization': 'JWT $token',
                          //         }),
                          //         data: formData)
                          //     .then((response) => print(response))
                          //     .catchError((error) => print(error));