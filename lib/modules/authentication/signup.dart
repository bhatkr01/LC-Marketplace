import 'package:flutter/material.dart';
import '../../../main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/api/accounts/accounts_api.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<SignUp> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  bool passwordVisible = true;
  bool passwordVisible1 = true;
  var matchPassword = '';
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> signUpController = {
    'email': TextEditingController(),
    'first_name': TextEditingController(),
    'last_name': TextEditingController(),
    'class_status': TextEditingController(),
    'password': TextEditingController(),
    'password2': TextEditingController(),
  };

  @override
  void dispose() {
    signUpController.forEach((k, v) => v.dispose());
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    passwordVisible = false;
    passwordVisible1 = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create New Account'),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: <Widget>[
              _emailField(),
              _firstNameField(),
              _lastNameField(),
              _classStatusField(),
              _passwordField(),
              _password2Field(),
              _submitField(),
            ],
          ),
        ));
  }

  Widget _emailField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextFormField(
        controller: signUpController['email'],
        validator: (value) {
          var valid = RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
          if (value == null || value.isEmpty || !valid.hasMatch(value)) {
            return 'Please enter valid email';
          }
          return null;
        },
        decoration: const InputDecoration(
          prefixIcon: Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.email),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide(color: Colors.blue)),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          labelText: 'Enter your email',
        ),
      ),
    );
  }

  Widget _firstNameField() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: TextFormField(
          controller: signUpController['first_name'],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your first name';
            }
            return null;
          },
          decoration: const InputDecoration(
            prefixIcon: Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.person),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                borderSide: BorderSide(color: Colors.blue)),
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            labelText: 'Enter your first name',
          ),
        ));
  }

  Widget _lastNameField() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: TextFormField(
          controller: signUpController['last_name'],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your last name';
            }
            return null;
          },
          decoration: const InputDecoration(
            prefixIcon: Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.person),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                borderSide: BorderSide(color: Colors.blue)),
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            labelText: 'Enter your last name',
          ),
        ));
  }

  Widget _classStatusField() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: TextFormField(
          controller: signUpController['class_status'],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select your class status';
            }
            return null;
          },
          decoration: const InputDecoration(
            prefixIcon: Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.group),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                borderSide: BorderSide(color: Colors.blue)),
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            labelText: 'Select your class status',
          ),
        ));
  }

  Widget _passwordField() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: TextFormField(
          controller: signUpController['password'],
          validator: (value) {
            matchPassword = value ?? '';
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            return null;
          },
          obscureText: !passwordVisible,
          decoration: InputDecoration(
            prefixIcon: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.lock),
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() => passwordVisible = !passwordVisible);
              },
              icon: Icon(
                  passwordVisible ? Icons.visibility_off : Icons.visibility),
            ),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                borderSide: BorderSide(color: Colors.blue)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            labelText: 'Enter your password',
          ),
        ));
  }

  Widget _password2Field() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: TextFormField(
          controller: signUpController['password2'],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            } else if (value != matchPassword) {
              return 'Your passwords do not match';
            } else {
              return null;
            }
          },
          obscureText: !passwordVisible,
          decoration: InputDecoration(
            prefixIcon: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.lock),
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() => passwordVisible = !passwordVisible);
              },
              icon: Icon(
                  passwordVisible ? Icons.visibility_off : Icons.visibility),
            ),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                borderSide: BorderSide(color: Colors.blue)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            labelText: 'Re-enter your password',
          ),
        ));
  }

  Widget _submitField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: (ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xFF0D47A1),
                      Color(0xFF1976D2),
                      Color(0xFF42A5F5),
                    ],
                  ),
                ),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16.0),
                textStyle: const TextStyle(
                  fontSize: 20,
                ),
              ),
              onPressed: () async {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  var signUpData = <String, dynamic>{};
                  signUpData['email'] = signUpController['email']!.text;
                  signUpData['first_name'] =
                      signUpController['first_name']!.text;
                  signUpData['last_name'] = signUpController['last_name']!.text;
                  signUpData['class_status'] =
                      signUpController['class_status']!.text;
                  signUpData['password'] = signUpController['password']!.text;
                  // signUpData['password2'] = signUpController['password2']!.text;

                  try {
                    await ref
                        .read(signUpProvider.notifier)
                        .signup(signUpData)
                        .then((_) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const MyHomePage(title: 'Luther Marketplace'),
                        ),
                      );
                    });
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Sign up error"),
                      duration: Duration(milliseconds: 50),
                    ));
                  }
                }
              },
              child: const Align(
                  alignment: Alignment.center,
                  child: Text('Submit', textAlign: TextAlign.center)),
            ),
          ],
        ),
      )),
    );
  }
}
