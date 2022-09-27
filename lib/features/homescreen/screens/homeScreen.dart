import 'package:blogs_assignment/models/authorModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return isLoaded
        ? SafeArea(
            child: Scaffold(
            appBar: AppBar(
              title: Text("HomeScreen"),
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            child: CircleAvatar(
                              radius: 40,
                              child: author!.profilePic!.isEmpty
                                  ? Image.network(
                                      'https://st4.depositphotos.com/4329009/19956/v/450/depositphotos_199564354-stock-illustration-creative-vector-illustration-default-avatar.jpg')
                                  : Image.network(
                                      author!.profilePic.toString()),
                            ),
                          ),
                        ),
                        Container(
                          child: Text(author!.name.toString()),
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.upload,
                    ),
                    title: const Text('Upload Blog'),
                    onTap: () {
                      Navigator.pushNamed(context, '/blogs_upload');
                    },
                  ),
                ],
              ),
            ),
            body: isLoaded ? Container() : Container(),
          ))
        : Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
  }
}
