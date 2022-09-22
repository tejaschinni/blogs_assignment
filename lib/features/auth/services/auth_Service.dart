import 'package:blogs_assignment/models/authorModel.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

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
    return _userFromFirebaseAuth(credential.user);
  }

  Future<Author?> createUser(String email, String password) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebaseAuth(credential.user);
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
