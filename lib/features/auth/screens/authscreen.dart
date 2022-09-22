import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Text('Blogs App'),
          ),
          Container(
            child: TextField(),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            child: TextField(),
          ),
          SizedBox(
            height: 5,
          ),
          ElevatedButton(onPressed: () {}, child: Text('Login')),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text("Google Sign Up"),
          )
        ],
      ),
    ));
  }
}
