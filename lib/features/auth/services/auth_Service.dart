import 'package:blogs_assignment/models/authorModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  Author? _userFromFirebaseAuth(auth.User? user) {
    if (user == null) {
      return null;
    } else {
      return Author(user.uid, user.email, user.displayName);
    }
  }

  Stream<Author?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebaseAuth);
  }

  Future<Author?> signInWithEmailandPassword(
      String email, String password) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);

    print(credential.user!.email);
    return _userFromFirebaseAuth(credential.user);
  }

  Future<Author?> createUser(String email, String password, String name) async {
    final credential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      FirebaseFirestore.instance
          .collection('blogs')
          .doc('data')
          .collection('author_Data')
          .doc(value.user!.email)
          .set({
        'id': value.user!.email,
        'email': value.user!.email,
        'name': name,
      });
    });

    return _userFromFirebaseAuth(credential.user);
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
