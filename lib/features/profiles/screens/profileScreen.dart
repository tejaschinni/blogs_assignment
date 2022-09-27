import 'package:blogs_assignment/features/auth/services/auth_Service.dart';
import 'package:blogs_assignment/models/authorModel.dart';
import 'package:blogs_assignment/provider/profileProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Author? author;
  bool isLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  getUser() {
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
        String uid;
        String name;
        String email;
        List blogs;
        String profilepic;
        if (value.exists) {
          setState(() {
            try {
              uid = value['uid'].toString();
            } catch (e) {
              uid = '';
            }
            try {
              name = value['name'].toString();
            } catch (e) {
              name = '';
            }
            try {
              email = value['email'].toString();
            } catch (e) {
              email = '';
            }
            try {
              blogs = value['blogs'];
            } catch (e) {
              blogs = [];
            }
            try {
              profilepic = value['profilepic'].toString();
            } catch (e) {
              profilepic = '';
            }
            author = Author(uid, name, email, blogs, profilepic);
            isLoaded = true;
          });
          return author;
        } else {
          return null;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final authService = Provider.of<AuthService>(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: isLoaded
          ? Column(
              children: [
                Container(
                  child: Text(author!.name.toString()),
                ),
              ],
            )
          : Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
    ));
  }
}
