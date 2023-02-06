import 'package:flutter/material.dart';
import '../authentication/login.dart';


class DrawerNavigation extends StatelessWidget{
  const DrawerNavigation({super.key});

  @override
  Widget build(BuildContext context){
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
              title: const Text('Login'),
              onTap: () {
Navigator.pushReplacement(context,
    MaterialPageRoute(builder: (context) => const Login()),
  );
                // Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
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
}
