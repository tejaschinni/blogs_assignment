import 'package:blogs_assignment/features/auth/screens/authscreen.dart';
import 'package:blogs_assignment/features/auth/services/auth_Service.dart';
import 'package:blogs_assignment/features/profiles/screens/profileScreen.dart';
import 'package:blogs_assignment/models/authorModel.dart';
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
      await FirebaseFirestore.instance
          .collection('blogs')
          .doc('data')
          .collection('author')
          .doc(event!.email.toString())
          .get()
          .then((value) {
        if (value.exists) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProfileScreen()));
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AuthScreen()));
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
