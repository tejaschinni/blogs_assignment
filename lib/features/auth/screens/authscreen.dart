import 'package:blogs_assignment/comman_widgets/customTextFields_widgets.dart';
import 'package:blogs_assignment/features/auth/services/auth_Service.dart';
import 'package:blogs_assignment/provider/profileProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  User? user;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);
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
          ElevatedButton(
              onPressed: () {
                // authService.signInWithEmailandPassword(
                //     emailController.text, passwordController.text);
              },
              child: Text('Login')),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/register');
            },
            child: Container(
              child: Text("Create account"),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () async {
              profileProvider.googleUser = await authService.loginWithGoogle();
              if (profileProvider.googleUser != null) {
                profileProvider.author = authService
                    .getUserData(profileProvider.googleUser!.email.toString());
                if (profileProvider.author != null) {
                  Navigator.pushNamed(context, '/blogs_upload');
                } else {
                  Navigator.pushNamed(context, '/register');
                }
              }
            },
            child: Text("Google Sign Up"),
          )
        ],
      ),
    ));
  }
}
