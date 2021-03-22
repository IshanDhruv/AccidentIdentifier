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
              actions: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    child:
                        Tooltip(child: Icon(Icons.person), message: "Sign in"),
                    onTap: () async {
                      widget.toggleView();
                    },
                  ),
                )
              ],
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
                        Text(error),
                      ],
                    ),
                  )),
            ),
          );
  }
}
