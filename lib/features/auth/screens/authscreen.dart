import 'package:blogs_assignment/comman_widgets/customTextFields_widgets.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
          CustomTextFieldWidgets(
              isVisible: false,
              controller: emailController,
              text: 'Enter Email'),
          SizedBox(
            height: 5,
          ),
          CustomTextFieldWidgets(
              isVisible: true,
              controller: passwordController,
              text: 'Enter PassWord'),
          SizedBox(
            height: 5,
          ),
          InkWell(
            // onTap: () {
            //   Navigator.pushNamed(context, '/');
            // },
            child: Container(
              child: Text("Create account"),
            ),
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
