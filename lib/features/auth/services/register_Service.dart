import 'package:blogs_assignment/models/authorModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterService {
  Author? author;
  checkUser(String useremail) async {
    FirebaseFirestore.instance
        .collection('blogs')
        .doc('data')
        .collection('user')
        .doc(useremail)
        .get()
        .then((value) {
      if (value.exists) {
        author = Author(value['uid'], value['name'], value['email'],
            value['blogs'], value['profilePic']);
        return author;
      } else {
        return null;
      }
    });
  }

  registerUser(String userEmail, String name, String uid, String profilepic,
      List blogs) async {
    FirebaseFirestore.instance
        .collection('blogs')
        .doc('data')
        .collection('user')
        .doc(userEmail)
        .set({
      'uid': userEmail,
      'email': userEmail,
      'name': name,
      'profilePic': profilepic,
      'blogs': blogs
    });
  }
}
