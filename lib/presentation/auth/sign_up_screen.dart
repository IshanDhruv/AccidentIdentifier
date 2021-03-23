import 'package:accident_identifier/services/auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  final Function toggleView;

  SignUpScreen({this.toggleView});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _email = '';
  String _password = '';
  String error = '';
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  Auth auth = Auth();

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: Text("Register"),
            ),
            body: SingleChildScrollView(
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
                              labelText: "Email", border: OutlineInputBorder()),
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
                        RaisedButton(
                            child: Text("Register"),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                var result =
                                    await auth.registerWithEmailAndPassword(
                                        _email, _password);
                                if (result == null)
                                  setState(() {
                                    error = 'Need valid email and password';
                                    isLoading = false;
                                  });
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
                        SizedBox(height: 20),
                        _signUpButton(),
                        SizedBox(height: 20),
                        Text(error),
                      ],
                    ),
                  )),
            ),
          );
  }

  Widget _signUpButton() {
    return Container(
      margin: EdgeInsets.all(20),
      height: 50,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        color: Colors.red[400],
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
          auth.signInWithGoogle();
        },
      ),
    );
  }
}
