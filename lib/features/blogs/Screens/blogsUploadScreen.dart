import 'package:flutter/material.dart';

class BlogsUploadScreen extends StatefulWidget {
  const BlogsUploadScreen({super.key});

  @override
  State<BlogsUploadScreen> createState() => _BlogsUploadScreenState();
}

class _BlogsUploadScreenState extends State<BlogsUploadScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              child: Text("Upload Blog"),
            ),
            Container(
              child: Text("upload blog image "),
            ),
            Container(
              child: TextField(
                decoration: InputDecoration(hintText: 'Title'),
              ),
            ),
            Container(
              child: TextField(
                decoration: InputDecoration(hintText: 'subtitle'),
              ),
            ),
            Container(
              child: TextField(
                decoration: InputDecoration(hintText: 'description'),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
