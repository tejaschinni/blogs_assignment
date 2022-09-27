import 'package:blogs_assignment/models/authorModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  auth.User? loginUser;
  Author? author;
  Author? _userFromFirebaseAuth(auth.User? user) {
    if (user == null) {
      return null;
    } else {
      FirebaseFirestore.instance
          .collection('blogs')
          .doc('data')
          .collection('author')
          .doc(user.email.toString())
          .get()
          .then((value) {
        String uid;
        String name;
        String email;
        List blogs;
        String profilepic;
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
      });
      return author;
    }
  }

  Stream<Author?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebaseAuth);
  }

  // Future<Author?> signInWithEmailandPassword(
  //     String email, String password) async {
  //   final credential = await _firebaseAuth.signInWithEmailAndPassword(
  //       email: email, password: password);

  //   print(credential.user!.email);
  //   return _userFromFirebaseAuth(credential.user);
  // }

  // Future<Author?> createUser(String email, String password, String name) async {
  //   final credential = await _firebaseAuth
  //       .createUserWithEmailAndPassword(email: email, password: password)
  //       .then((value) async {
  //     FirebaseFirestore.instance
  //         .collection('blogs')
  //         .doc('data')
  //         .collection('author_Data')
  //         .doc(value.user!.email)
  //         .set({
  //       'id': value.user!.email,
  //       'email': value.user!.email,
  //       'name': name,
  //     });
  //   });

  //   return _userFromFirebaseAuth(credential.user);
  // }

  Author? getUserData(String email) {
    FirebaseFirestore.instance
        .collection('blog')
        .doc('data')
        .collection('author')
        .doc(email)
        .get()
        .then((value) {
      String uid;
      String name;
      String email;
      List blogs;
      String profilepic;
      if (value.exists) {
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
        print(author!.name.toString());
        return author;
      } else {
        return null;
      }
    });
  }

  Future<GoogleSignInAccount?> loginWithGoogle() async {
    try {
      final googleUser = await googleSignIn.signIn();

      final googleAuth = await googleUser?.authentication;
      if (googleAuth != null) {
        final credenti = auth.GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await auth.FirebaseAuth.instance.signInWithCredential(credenti);
        return googleUser;
      }
    } on auth.FirebaseAuthException catch (e) {}
  }

  registerUser(String email, String name, String profilepic, List blogs) async {
    FirebaseFirestore.instance
        .collection('blog')
        .doc('data')
        .collection('author')
        .doc(email)
        .set({
      'uid': email.toString(),
      'email': email.toString(),
      'name': name.toString(),
      'blogs': blogs,
      'profilepic': profilepic.toString(),
    });
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut().then((value) {
      googleSignIn.signOut();
    });
  }
}
