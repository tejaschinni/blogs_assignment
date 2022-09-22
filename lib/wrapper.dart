import 'package:blogs_assignment/features/auth/screens/authscreen.dart';
import 'package:blogs_assignment/features/auth/services/auth_Service.dart';
import 'package:blogs_assignment/models/authorModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<Author?>(
        stream: authService.user,
        builder: (_, AsyncSnapshot<Author?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final Author? author = snapshot.data;
            return author == null
                ? AuthScreen()
                : Container(
                    child: Text("Author"),
                  );
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator() ,
              ),
            );
          }
        });
  }
}
