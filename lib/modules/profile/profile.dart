import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../data/api/accounts/accounts_api.dart';
import '../../modules/home/product_card.dart';
import '../../data/api/product/product_api.dart';


class Profile extends ConsumerStatefulWidget {
const Profile({Key? key}): super(key:key);
  @override
  // ConsumerState<Profile> createState() => _ProfileState();
  ProfileState createState() => ProfileState();
}

class ProfileState extends ConsumerState<Profile> {
String token ='';

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final products=ref.watch(productsProvider);

    getToken("access").then((value) => setState((){
      token=value?? '';
    }

    ));
    if (token!=''){
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    return products.when(
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
      data: (products){
                          return Column(
                            children: [
                              _yourProfile(),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: CustomScrollView(
                                    shrinkWrap: true,
                                                      primary: false,
                                  slivers: <Widget>[
                                    SliverPadding(
                                      padding: const EdgeInsets.all(20),
                                      sliver: SliverGrid.count(
                                        crossAxisSpacing: 0,
                                        mainAxisSpacing: 0,
                                        childAspectRatio:MediaQuery.of(context).size.width<601? 0.6: 0.8,
                                        crossAxisCount: MediaQuery.of(context).size.width<601? 2: 3,
                                        children: 
                                          _filteredProducts(products, decodedToken['user_id'])
                                      // products.map((product) {
                                      //     if (product.productAuthor==userId){
                                      //       return ProductCard(product:product);
                                      //     }
                                      // });
                                      ),
                                    ),
                                  ],
                                                    ),
                                ),
                              ),
                            ],
                          );
      }
    );
      //  return Column(
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children:<Widget>[
      //       _yourProfile(),
      //       const Expanded(
      //         child:  Center(
      //           child: Text(
      //             "You have 1 posts yet",
      //             style:TextStyle(fontSize: 20.0)
      //             )
      //         )
      //       ),
      //     ],
      //   );
    }

    else{
       return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:<Widget>[
            _yourProfile(),
            const Expanded(
              child:  Center(
                child: Text(
                  "You have no posts yet",
                  style:TextStyle(fontSize: 20.0)
                  )
              )
            ),
          ],
        );
    }

    }
  }

  Widget _yourProfile() {
    return
    Padding(
      padding: const EdgeInsets.symmetric(vertical:15.0, horizontal: 20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          

        _columnComponent(
          const CircleAvatar(backgroundImage: AssetImage('assets/images/lion.jpg'), radius: 30.0,),
          const Text(
            'Kritib Bhattarai',
            style: TextStyle( fontSize: 18.0),
          ),

        ),
        _columnComponent(
          const Text(
            '0',
            style: TextStyle( fontSize: 18.0),
          ),
          const Text(
            'Posts',
            style: TextStyle( fontSize: 18.0),
          ),

        ),
        _columnComponent(
          const Text(
            '0',
            style: TextStyle( fontSize: 18.0),
          ),
          const Text(
            'Donations',
            style: TextStyle( fontSize: 18.0),
          ),

        ),


        ],
        ),
    );


  }

  Widget _columnComponent(Widget top, Widget bottom) {
    return Column(
            mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        top,
          const SizedBox(height:10),
          bottom,

    ],
    );
  }

  List<Widget> _filteredProducts(List products, int userId) {
    List<Widget> a=[];
    for (int index=0; index< products.length; index++){
          if (products[index].productAuthor==userId){
              a.add(ProductCard(product:products[index]));
          }

    }
      return a;



      

          }





  //   // Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
  //   // print(decodedToken['user_id']);
