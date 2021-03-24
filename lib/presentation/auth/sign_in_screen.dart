import 'package:accident_identifier/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInScreen extends StatefulWidget {
  final Function toggleView;

  SignInScreen({this.toggleView});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String _email = '';
  String _password = '';
  String error = '';
  bool isLoading = false;
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final _auth = watch(authServicesProvider);
        return Scaffold(
          appBar: AppBar(
            title: Text("Sign In"),
          ),
          body: isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                    color: Colors.white,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Form(
                            key: _formkey,
                            child: Column(
                              children: <Widget>[
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
                                    child: Text("Sign in"),
                                    onPressed: () async {
                                      if (_formkey.currentState.validate()) {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        print('valid');
                                        var result = await _auth
                                            .signInWithEmailAndPassword(
                                                _email, _password);
                                        if (result == null)
                                          setState(() {
                                            error = 'Couldnt sign in';
                                            isLoading = false;
                                          });
                                      }
                                    }),
                                SizedBox(height: 20),
                                Text(error),
                                SizedBox(height: 20),
                                GestureDetector(
                                  child: Text(
                                    "Dont have an account? Sign Up",
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
                          ),
                          SizedBox(height: 50),
                          _signInButton(),
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }

  Widget _signInButton() {
    return Consumer(
      builder: (context, watch, child) {
        final _auth = watch(authServicesProvider);
        return Container(
          margin: EdgeInsets.all(20),
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.red[400],
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  'assets/google_logo.png',
                  height: 30,
                ),
                Text(
                  "Sign in with Google",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
            onPressed: () {
              _auth.signInWithGoogle();
            },
          ),
        );
      },
    );
  }
}
