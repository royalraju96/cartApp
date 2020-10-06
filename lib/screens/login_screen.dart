import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';

  final Function _setLoginState;

  final bool currentState;

  LoginScreen(this.currentState, this._setLoginState);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  String errorMessage;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: Text('Loading.....'),
          )
        : Container(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Center(
                    child: Text(
                      'Login',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Enter email id'),
                    controller: username,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: password,
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Enter password'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (username.text == '') return;
                      if (password.text == '') return;

                      isLoading = true;

                      _auth
                          .signInWithEmailAndPassword(
                              email: username.text, password: password.text)
                          .then((value) {
                        isLoading = false;

                        widget._setLoginState(true);
                      }).catchError((onError) {
                        isLoading = false;
                        errorMessage = onError.toString();
                      });
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (errorMessage != null)
                    Text(
                      errorMessage,
                      style: TextStyle(color: Colors.black),
                    )
                ],
              ),
            ),
          );
  }
}
