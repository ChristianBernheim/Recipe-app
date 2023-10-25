import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/components/text_field_widget.dart';
import 'package:recipe_app/components/title_tile.dart';
import 'package:recipe_app/model/user.dart';
import 'package:recipe_app/services/firestore_service.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel user;
  EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final db = FireStoreService();

  void editUser(UserModel user) async {
    await db.updateUser(user);
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: EdgeInsets.all(25),
        child: Column(children: [
          TitleTile(title: "Edit profile"),
          SizedBox(
            height: 25,
          ),
          Text(
            "Change your firstname",
            style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
                fontWeight: FontWeight.bold),
          ),
          TextFieldWidget(
            labelText: widget.user.firstname,
            controller: _firstnameController,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Change your lastname",
            style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
                fontWeight: FontWeight.bold),
          ),
          TextFieldWidget(
            labelText: widget.user.lastname,
            controller: _lastnameController,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Change password",
            style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
                fontWeight: FontWeight.bold),
          ),
          TextFieldWidget(
            labelText: "Password",
            controller: _passwordController,
          ),
          SizedBox(
            height: 5,
          ),
          TextFieldWidget(
            labelText: "Confirm password",
            controller: _confirmPasswordController,
          ),
          ElevatedButton(
              onPressed: () {
                if (_confirmPasswordController.text ==
                    _passwordController.text) {
                  if (_firstnameController != null &&
                      _firstnameController != widget.user.firstname) {
                    widget.user.firstname = _firstnameController.text.trim();
                  }
                  if (_lastnameController != null &&
                      _lastnameController != widget.user.lastname) {
                    widget.user.lastname = _lastnameController.text.trim();
                  }
                  currentUser!.updatePassword(_passwordController.text.trim());
                  editUser(widget.user);
                  Navigator.pop(context);
                }
              },
              child: Text("Edit profile"))
        ]),
      ),
    );
  }
}
