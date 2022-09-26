import 'package:blogs_assignment/features/auth/screens/authscreen.dart';
import 'package:blogs_assignment/features/auth/screens/registerScreen.dart';
import 'package:blogs_assignment/features/auth/services/auth_Service.dart';
import 'package:blogs_assignment/features/auth/services/register_Service.dart';
import 'package:blogs_assignment/features/blogs/Screens/blogsUploadScreen.dart';
import 'package:blogs_assignment/provider/profileProvider.dart';
import 'package:blogs_assignment/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        Provider<ProfileProvider>(
          create: (_) => ProfileProvider(),
        ),
        Provider<RegisterService>(
          create: (_) => RegisterService(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Blogs App',
        theme: ThemeData(),
        initialRoute: '/',
        routes: {
          // '/': (context) => BlogsUploadScreen(),
          '/': (context) => Wrapper(),
          '/authScreen': (context) => AuthScreen(),
          '/register': (context) => RegisterScreen(),
          '/blogs_upload': (context) => BlogsUploadScreen()
        },
      ),
    );
  }
}
