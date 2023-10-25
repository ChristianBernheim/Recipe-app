import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
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

  final db = FireStoreService();
  uploadImage(String path) async {
    if (path == null) return;

    try {
      Reference ref = _storage
          .ref()
          .child('profile_images/${DateTime.now().millisecondsSinceEpoch}');

      final result = await ref.putFile(File(path));
      String fileUrl = await result.ref.getDownloadURL();
      widget.user.profilePicture = fileUrl;
      await db.updateUser(widget.user);
    } catch (e) {
      print('error occurred: $e');
    }
  }

  _pickImage(ImageSource source) async {
    final pickedFile =
        await ImagePicker().pickImage(source: source, imageQuality: 15);
    if (pickedFile == null) return;
    var file = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1));
    uploadImage(file!.path);
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
                        _pickImage(ImageSource.gallery);
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
                        _pickImage(ImageSource.camera);
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
