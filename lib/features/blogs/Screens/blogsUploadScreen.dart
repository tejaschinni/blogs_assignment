import 'dart:typed_data';

import 'package:blogs_assignment/features/blogs/services/blogs_Service.dart';
import 'package:blogs_assignment/uitls/uitls.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BlogsUploadScreen extends StatefulWidget {
  const BlogsUploadScreen({super.key});

  @override
  State<BlogsUploadScreen> createState() => _BlogsUploadScreenState();
}

class _BlogsUploadScreenState extends State<BlogsUploadScreen> {
  Uint8List? _file;
  bool _isLoading = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: EdgeInsets.all(15),
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () async {
                Uint8List file = await pickImage(ImageSource.gallery);

                setState(() {
                  _file = file;
                });
              },
              child: Container(
                child: Text("Upload Blog"),
              ),
            ),
            Container(
              child: Text("upload blog image "),
            ),
            Container(
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(hintText: 'Title'),
              ),
            ),
            Container(
              child: TextField(
                controller: subtitleController,
                decoration: InputDecoration(hintText: 'subtitle'),
              ),
            ),
            Container(
              child: TextField(
                controller: descriptionController,
                decoration: InputDecoration(hintText: 'description'),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  _uploadBlog('tejaschinni14@gmail.com ', 'teh',
                      'https://st4.depositphotos.com/4329009/19956/v/450/depositphotos_199564354-stock-illustration-creative-vector-illustration-default-avatar.jpg');
                },
                child: Text("Upload"))
          ],
        ),
      ),
    ));
  }

  void _uploadBlog(
    String uid,
    String username,
    String profileImage,
  ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      print("Started");
      String res = await BlogsService().uploadPost(
        descriptionController.text,
        _file!,
        titleController.text,
        subtitleController.text,
        uid,
      );
      print("finish ");

      if (res == 'success') {
        setState(() {
          _isLoading = false;
        });
        showSnackBar("Posted!", context);
        clearImage();
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }
}
