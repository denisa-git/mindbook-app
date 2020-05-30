import 'package:flutter/material.dart';
import 'package:mindbook/services/auth_service.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreen createState() {
    return _AuthScreen();
  }
}

class _AuthScreen extends State<AuthScreen> {
  AuthService _auth;
  GlobalKey<FormState> _formKey;
  GlobalKey<ScaffoldState> _scaffoldKey;
  String _email;
  String _password;

  @override
  void initState() {
    super.initState();
    _auth = AuthService();
    _formKey = GlobalKey<FormState>();
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Mindbook',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('Welcome back!'),
                        ],
                      ),
                    ),
                    TextFormField(
                      maxLines: 1,
                      keyboardType: TextInputType.emailAddress,
                      autofocus: false,
                      decoration: new InputDecoration(
                          hintText: 'Email',
                          icon: new Icon(
                            Icons.mail_outline,
                          )),
                      validator: (value) =>
                          value.isEmpty ? 'Email cannot be empty' : null,
                      onSaved: (value) => _email = value.trim(),
                    ),
                    TextFormField(
                      maxLines: 1,
                      obscureText: true,
                      autofocus: false,
                      decoration: new InputDecoration(
                          hintText: 'Password',
                          icon: new Icon(
                            Icons.lock_outline,
                          )),
                      validator: (value) =>
                          value.isEmpty ? 'Password cannot be empty' : null,
                      onSaved: (value) => _password = value.trim(),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: FlatButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              await _auth
                                  .signInWithEmail(_email, _password)
                                  .catchError((e) {
                                final snackBar = SnackBar(content: Text(e));
                                _scaffoldKey.currentState
                                    .showSnackBar(snackBar);
                              });
                            }
                          },
                          color: Colors.black,
                          child: Text(
                            'Sign In',
                            style: TextStyle(color: Colors.white),
                          ),
                          shape: StadiumBorder()),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: OutlineButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              await _auth
                                  .signUpWithEmail(_email, _password)
                                  .catchError((e) {
                                final snackBar = SnackBar(content: Text(e));
                                _scaffoldKey.currentState
                                    .showSnackBar(snackBar);
                              });
                            }
                          },
                          child: Text('Sign Up'),
                          shape: StadiumBorder()),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: FlatButton(
                          onPressed: () async {
                            _formKey.currentState.save();
                            if (_email != '') {
                              await _auth.forgotPassword(_email).then((_) {
                                final snackBar =
                                    SnackBar(content: Text('Email sent'));
                                _scaffoldKey.currentState
                                    .showSnackBar(snackBar);
                              }).catchError((e) {
                                final snackBar = SnackBar(content: Text(e));
                                _scaffoldKey.currentState
                                    .showSnackBar(snackBar);
                              });
                            } else {
                              final snackBar = SnackBar(
                                  content: Text(
                                      'An email address must be provided'));
                              _scaffoldKey.currentState.showSnackBar(snackBar);
                            }
                          },
                          child: Text(
                            'Forgot your password?',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          shape: StadiumBorder()),
                    ),
                    Spacer(),
                    Divider(),
                    SizedBox(
                      width: double.infinity,
                      child: FlatButton.icon(
                          onPressed: () async {
                            await _auth.signInWithGoogle().catchError((e) {
                              final snackBar = SnackBar(content: Text(e));
                              _scaffoldKey.currentState.showSnackBar(snackBar);
                            });
                          },
                          color: Colors.blue,
                          textColor: Colors.white,
                          icon: Icon(Icons.person),
                          label: Text('Sign in with Google'),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30),
                          )),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: FlatButton(
                          onPressed: () async {
                            await _auth.signInAnonymously().catchError((e) {
                              final snackBar = SnackBar(content: Text(e));
                              _scaffoldKey.currentState.showSnackBar(snackBar);
                            });
                          },
                          color: Colors.grey,
                          textColor: Colors.white,
                          child: Text('Sign in anonymously'),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30),
                          )),
                    )
                  ],
                )),
          ),
        ),
      );
}
