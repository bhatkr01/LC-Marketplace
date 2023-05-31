import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../data/api/accounts/accounts_api.dart';
import '../../modules/home/product_card.dart';
import '../../data/api/product/product_api.dart';
import '../authentication/login.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  // ConsumerState<Profile> createState() => _ProfileState();
  ProfileState createState() => ProfileState();
}

class ProfileState extends ConsumerState<Profile> {
  String token = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.read(productsProvider);
    getToken("access").then((value) => setState(() {
          token = value ?? '';
        }));
    if (token != '') {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      return products.when(
          loading: () => const CircularProgressIndicator(),
          error: (err, stack) => Text('Error: $err'),
          data: (products) {
            var filteredProducts = [];
            List<Widget> filteredProductsWidgets = [];
            var donationsCount = 0;
            for (int index = 0; index < products.length; index++) {
              if (products[index].productAuthor == decodedToken['user_id']) {
                filteredProducts.add(products[index]);
                filteredProductsWidgets
                    .add(ProductCard(product: products[index]));
              }
              if (products[index].productAction == 'DONATE') {
                donationsCount += 1;
              }
            }

            return Column(
              children: [
                _yourProfile(
                    filteredProducts, donationsCount, decodedToken['user_id']),
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
                              childAspectRatio:
                                  MediaQuery.of(context).size.width < 601
                                      ? 0.6
                                      : 0.8,
                              crossAxisCount:
                                  MediaQuery.of(context).size.width < 601
                                      ? 2
                                      : 3,
                              children: filteredProductsWidgets),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          });
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // _yourProfile(),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child:
                Text("You have no posts yet", style: TextStyle(fontSize: 20.0)),
          ),

          ElevatedButton(
            child: const Text('Login'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
              );
            },
          ),
        ],
      );
    }
  }
}

Widget _yourProfile(List products, int donationsCount, int userID) {
  var productsLength = products.length;
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _columnComponent(
          const CircleAvatar(
            backgroundImage: AssetImage('assets/images/lion.jpg'),
            radius: 30.0,
          ),

          FutureBuilder(
            future: getUser(userID),
            builder: (ctx, snapshot) {
              if (snapshot.hasData) {
                // Extracting data from snapshot object
                final data = snapshot.data;

                return Center(
                  child: Text(
                    '${data!.firstName} ${data.lastName}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error} occurred',
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              }

              // Displaying LoadingSpinner to indicate waiting state
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),

          // const Text(
          //   'Kritib Bhattarai',
          //   style: TextStyle(fontSize: 18.0),
          // ),
        ),
        _columnComponent(
          Text(
            productsLength.toString(),
            style: const TextStyle(fontSize: 18.0),
          ),
          const Text(
            'Posts',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
        _columnComponent(
          Text(
            donationsCount.toString(),
            style: const TextStyle(fontSize: 18.0),
          ),
          const Text(
            'Donations',
            style: TextStyle(fontSize: 18.0),
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
      const SizedBox(height: 10),
      bottom,
    ],
  );
}
