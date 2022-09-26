import 'package:blogs_assignment/comman_widgets/customTextFields_widgets.dart';
import 'package:blogs_assignment/features/auth/services/auth_Service.dart';
import 'package:blogs_assignment/features/auth/services/register_Service.dart';
import 'package:blogs_assignment/provider/profileProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final register = Provider.of<ProfileProvider>(context);
    print("ooooooooooooo");
    emailController.text = register.googleUser!.email.toString();

    return SafeArea(
      child: Scaffold(
          body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text("Register Page"),
            ),
            CustomTextFieldWidgets(
                controller: emailController,
                text: 'Enter email',
                isVisible: false),
            SizedBox(
              height: 5,
            ),
            CustomTextFieldWidgets(
                controller: nameController,
                text: 'Enter Name',
                isVisible: false),
            SizedBox(
              height: 5,
            ),
            CustomTextFieldWidgets(
                controller: passwordController,
                text: 'Enter Password',
                isVisible: false),
            SizedBox(
              height: 5,
            ),
            ElevatedButton(
                onPressed: () async {
                  authService.registerUser(
                      emailController.text,
                      nameController.text,
                      register.googleUser!.photoUrl.toString(), []);
                },
                child: Text("Register "))
          ],
        ),
      )),
    );
  }
}
