import 'package:flutter/material.dart';
import '../../main.dart';

class AddProducts extends StatelessWidget{
  final _formKey = GlobalKey<FormState>();
  AddProducts({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: const Text('Upload a Product'),
          // centerTitle:false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const MyHomePage(title: "Luther Marketplace")),
              );
            },
          ),
        ),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: Image.asset('assets/images/lion.jpg',
                          height: 300, width: 300)
                      // child: Image.asset('assets/images/lion.jpg', fit:BoxFit.fill)
                      ),
                  // _emailField(),
                  // _passwordField(),
                  // _submitField()
                ],
              ),
            ))
        );

  }
}