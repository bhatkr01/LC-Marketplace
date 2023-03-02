import 'package:flutter/material.dart';
import '../../data/api/accounts/accounts_api.dart';
import '../authentication/login.dart';
import '../product/add_products.dart';





class DrawerNavigation extends StatefulWidget{

  const DrawerNavigation({super.key});

  @override
  State<DrawerNavigation> createState() => _DrawerNavigationState();
}


class _DrawerNavigationState extends State<DrawerNavigation> {
  String? token;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    getToken("access").then((value) => setState((){
      token=value;
    }
    ));


    if (token!=null){
      return _logoutOnly(context);
  }
  else{
   return _loginOnly(context);

  }


}
}

Widget _loginOnly(context){
    return 
Drawer(
  width: MediaQuery.of(context).size.width/2,
child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Add Products'),
              onTap: () {
Navigator.pushReplacement(context,
    MaterialPageRoute(builder: (context) => AddProducts()),
  );
              },
            ),
            ListTile(
              title: const Text('Login'),
              onTap: () {
Navigator.pushReplacement(context,
    MaterialPageRoute(builder: (context) => const Login()),
  );
              },
            ),
          ],
        ),

          );
}
Widget _logoutOnly(context){

    return 
Drawer(
  width: MediaQuery.of(context).size.width/2,
child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Add Products'),
              onTap: () {
Navigator.pushReplacement(context,
    MaterialPageRoute(builder: (context) =>  AddProducts()),
  );
              },
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                deleteToken();
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),

          );
}
