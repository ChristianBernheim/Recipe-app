import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/model/user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:recipe_app/services/firestore_service.dart';

class CameraOrLibraryTile extends StatefulWidget {
  final UserModel user;
  CameraOrLibraryTile({super.key, required this.user});

  @override
  State<CameraOrLibraryTile> createState() => _CameraOrLibraryTileState();
}

class _CameraOrLibraryTileState extends State<CameraOrLibraryTile> {
  FirebaseStorage _storage = FirebaseStorage.instance;

  File? _image;
  final db = FireStoreService();
  uploadImage() async {
    if (_image == null) return;

    try {
      Reference ref = _storage
          .ref()
          .child('profile_images/${DateTime.now().millisecondsSinceEpoch}');
      UploadTask uploadTask = ref.putFile(_image!);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      setState(() {
        widget.user.profilePicture = downloadUrl;
      });
      await db.updateUser(widget.user);
      Navigator.pop(context);
    } catch (e) {
      print('error occurred: $e');
    }
  }

//Using camera to upload a picture
  _imgFromCamera() async {
    final pickedImage = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 15);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        uploadImage();
      });
    }
  }

//Getting image from library
  _imgFromLibrary() async {
    final pickedImage = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 15);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        uploadImage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width / 1,
        height: MediaQuery.of(context).size.height / 3,
        child: AlertDialog(
          backgroundColor:
              Theme.of(context).colorScheme.tertiary.withOpacity(0.8),
          title: Center(
            child: Text(
              "Choose between",
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          content: Column(
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      color: Theme.of(context).colorScheme.primary,
                      iconSize: 50,
                      onPressed: () {
                        Navigator.pop(context);
                        _imgFromLibrary();
                      },
                      icon: Icon(Icons.photo_library),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    IconButton(
                      color: Theme.of(context).colorScheme.primary,
                      iconSize: 50,
                      onPressed: () {
                        Navigator.pop(context);
                        _imgFromCamera();
                      },
                      icon: Icon(Icons.photo_camera),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
