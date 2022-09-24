import 'package:blogs_assignment/comman_widgets/customTextFields_widgets.dart';
import 'package:blogs_assignment/features/auth/services/auth_Service.dart';
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
                  await authService.createUser(emailController.text,
                      passwordController.text, nameController.text.toString());
                },
                child: Text("Register "))
          ],
        ),
      )),
    );
  }
}
