import 'package:flutter/material.dart';
import '../../../main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/api/accounts/accounts_api.dart';
import './signup.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  bool passwordVisible = true;
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> loginController = {
    'email': TextEditingController(),
    'password': TextEditingController(),
  };

  @override
  void dispose() {
    loginController.forEach((k, v) => v.dispose());
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: const Text('LOGIN'),
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
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    // child: SizedBox(
                    //   height:height,
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      // mainAxisSize: MainAxisSize.min,

                      children: [
                        Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 1),
                                child: Image.asset('assets/images/lion.jpg',
                                    height: 300, width: 300)
                                // child: Image.asset('assets/images/lion.jpg', fit:BoxFit.fill)
                                ),
                            _emailField(),
                            _passwordField(),
                            _submitField(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // ),
                // const Spacer(flex:1),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _createAccount(),
                )
              ],
            )));
  }

  Widget _emailField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextFormField(
        controller: loginController['email'],
        validator: (value) {
          var valid = RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
          if (value == null || value.isEmpty || !valid.hasMatch(value)) {
            return 'Please enter valid email';
          }
          return null;
        },
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Enter your email',
          icon: Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.email),
          ),
        ),
      ),
    );
  }

  Widget _passwordField() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: TextFormField(
          controller: loginController['password'],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some Text';
            }
            return null;
          },
          obscureText: !passwordVisible,
          decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            labelText: 'Enter your password',
            icon: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.lock),
            ),
            suffixIcon: IconButton(
              onPressed: (() =>
                  setState(() => passwordVisible = !passwordVisible)),
              icon: Icon(
                  passwordVisible ? Icons.visibility_off : Icons.visibility),
            ),
          ),
        ));
  }

  Widget _submitField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: (ClipRRect(
        borderRadius: BorderRadius.circular(4),
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
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () async {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  var loginData = <String, dynamic>{};
                  loginData['email'] = loginController['email']!.text;
                  loginData['password'] = loginController['password']!.text;

                  try {
                    await ref
                        .read(loginProvider.notifier)
                        .login(loginData)
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
                      content: Text("Login Error"),
                      duration: Duration(milliseconds: 50),
                    ));
                  }
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      )),
    );
  }

  Widget _createAccount() {
    return TextButton(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SignUp(),
          ),
        );
      },
      child: const Text('New User? Create Account'),
    );
  }
}
