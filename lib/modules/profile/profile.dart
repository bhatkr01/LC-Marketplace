import 'package:flutter/material.dart';


class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
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
}




