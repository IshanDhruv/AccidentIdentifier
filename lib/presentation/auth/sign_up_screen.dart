import 'package:accident_identifier/presentation/base_screen.dart';
import 'package:accident_identifier/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpScreen extends StatefulWidget {
  final Function toggleView;

  SignUpScreen({this.toggleView});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _name = '';
  String _email = '';
  String _phoneNumber = '';
  String _password = '';
  String error = '';
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final _auth = watch(authServicesProvider);
      return Scaffold(
        appBar: AppBar(
          title: Text("Register"),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 20),
                          TextFormField(
                            autofocus: true,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                labelText: "Name",
                                border: OutlineInputBorder()),
                            validator: (val) =>
                                val.isEmpty ? 'Enter your name' : null,
                            onChanged: (val) {
                              setState(() {
                                _name = val;
                              });
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            autofocus: true,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                labelText: "Email",
                                border: OutlineInputBorder()),
                            validator: (val) =>
                                val.isEmpty ? 'Enter an email' : null,
                            onChanged: (val) {
                              setState(() {
                                _email = val;
                              });
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                labelText: "Phone Number",
                                border: OutlineInputBorder()),
                            validator: (val) => val.length != 10
                                ? 'Phone number should be 10 characters'
                                : null,
                            onChanged: (val) {
                              _phoneNumber = val;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                                labelText: "Password",
                                border: OutlineInputBorder()),
                            validator: (val) => val.length < 6
                                ? 'Password should be longer than 6 characters'
                                : null,
                            onChanged: (val) {
                              _password = val;
                            },
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                              child: Text("Sign Up"),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  var result = await _auth.signUp(
                                      _name, _email, _phoneNumber, _password);
                                  if (result == null)
                                    setState(() {
                                      error = 'Need valid credentials';
                                      isLoading = false;
                                    });
                                  else {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BaseScreen()));
                                  }
                                }
                              }),
                          SizedBox(height: 20),
                          GestureDetector(
                            child: Text(
                              "Already have an account? Sign in",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            onTap: () {
                              widget.toggleView();
                            },
                          ),
                        ],
                      ),
                    )),
              ),
      );
    });
  }
}
