import 'package:accident_identifier/presentation/home_screen.dart';
import 'package:accident_identifier/services/auth.dart';
import 'package:flutter/material.dart';

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
  Auth auth = Auth();

  @override
  Widget build(BuildContext context) {
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
                            RaisedButton(
                                child: Text("Sign in"),
                                onPressed: () async {
                                  if (_formkey.currentState.validate()) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    print('valid');
                                    var result =
                                        await auth.signInWithEmailAndPassword(
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
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        auth.signInWithGoogle().then((result) {
          if (result != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return HomeScreen();
                },
              ),
            );
          }
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/images/g_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
