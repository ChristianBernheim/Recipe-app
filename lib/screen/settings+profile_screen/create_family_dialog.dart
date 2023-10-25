import 'package:flutter/material.dart';

import 'package:recipe_app/components/text_field_widget.dart';
import 'package:recipe_app/model/family.dart';
import 'package:recipe_app/model/user.dart';
import 'package:recipe_app/services/firestore_service.dart';

class CreateFamilyDialog extends StatefulWidget {
  final UserModel user;
  const CreateFamilyDialog({super.key, required this.user});

  @override
  State<CreateFamilyDialog> createState() => _CreateFamilyDialogState();
}

class _CreateFamilyDialogState extends State<CreateFamilyDialog> {
  final _nameController = TextEditingController();
  final db = FireStoreService();

  createFamily(UserModel user) async {
    List familyMembers = [user.uId];
    final family = FamilyModel(
        name: _nameController.text.trim(), familyMembersId: familyMembers);
    await db.createFamily(family, user);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(25)),
            child: Column(
              children: [
                Text("Create your family"),
                TextFieldWidget(
                    labelText: "Family name", controller: _nameController),
                ElevatedButton(
                    onPressed: () {
                      createFamily(widget.user);
                    },
                    child: Text("Add family"))
              ],
            )),
      ),
    );
  }
}
