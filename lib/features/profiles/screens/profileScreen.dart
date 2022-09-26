import 'package:blogs_assignment/features/auth/services/auth_Service.dart';
import 'package:blogs_assignment/provider/profileProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final authService = Provider.of<AuthService>(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Column(
        children: [
          Container(
            child: Text(authService.user.toString()),
          ),
        ],
      ),
    ));
  }
}
