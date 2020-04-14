import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                TextField(
                    decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.black),
                )),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: FlatButton(
                      onPressed: () {},
                      color: Colors.black,
                      textColor: Colors.white,
                      child: Text('Sign In'),
                      shape: StadiumBorder()),
                ),
                SizedBox(
                  width: double.infinity,
                  child: OutlineButton(
                      onPressed: () {},
                      highlightedBorderColor: Colors.black,
                      textColor: Colors.black,
                      child: Text('Sign Up'),
                      shape: StadiumBorder()),
                ),
                SizedBox(
                  width: double.infinity,
                  child: FlatButton(
                      onPressed: () {},
                      textColor: Colors.black,
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
                      onPressed: () {},
                      color: Colors.blue,
                      textColor: Colors.white,
                      icon: Icon(Icons.navigate_next),
                      label: Text('Sign in with Google'),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30),
                          )),
                ),
              ],
            ),
          ),
        ),
      );
}
