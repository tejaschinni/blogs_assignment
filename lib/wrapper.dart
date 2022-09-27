import 'package:blogs_assignment/features/auth/screens/authscreen.dart';
import 'package:blogs_assignment/features/auth/services/auth_Service.dart';
import 'package:blogs_assignment/features/homescreen/screens/homeScreen.dart';
import 'package:blogs_assignment/features/profiles/screens/profileScreen.dart';
import 'package:blogs_assignment/models/authorModel.dart';
import 'package:blogs_assignment/provider/profileProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkuser();
  }

  checkuser() {
    FirebaseAuth.instance.authStateChanges().listen((event) async {
      print("----------------------");
      print(event!.email);
      await FirebaseFirestore.instance
          .collection('blog')
          .doc('data')
          .collection('author')
          .doc(event.email.toString())
          .get()
          .then((value) {
        print(event.email);
        if (value.exists) {
          // Provider.of<ProfileProvider>(context).user = event;
          Navigator.pushNamed(context, '/homeScreen');
        } else {
          Navigator.pushNamed(context, '/authScreen');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
