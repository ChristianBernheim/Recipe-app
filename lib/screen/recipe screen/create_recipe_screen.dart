import 'package:flutter/material.dart';
import 'package:recipe_app/components/ingredient.dart';
import 'package:recipe_app/components/text_field_widget.dart';
import 'package:recipe_app/components/title_tile.dart';
import 'package:recipe_app/model/ingredient_stuff.dart';
import 'package:recipe_app/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateRecipeScreen extends StatefulWidget {
  const CreateRecipeScreen({super.key});

  @override
  State<CreateRecipeScreen> createState() => AddRecipeState();
}

String? _selectedUnit;
final _titleController = TextEditingController();
final _ingredientNameController = TextEditingController();
final _ingredientAmountController = TextEditingController();
final _ingredientUnitController = _selectedUnit;

class AddRecipeState extends State<CreateRecipeScreen> {
  final db = FireStoreService();
  final currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Theme.of(context).colorScheme.background,
            Theme.of(context).colorScheme.primary,
          ],
        )),
        child: Column(
          children: [
            Stack(
              children: [TitleTile(title: "Add recipe")],
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFieldWidget(
                  labelText: "Title", controller: _titleController),
            ),
            SizedBox(
              height: 4,
            ),
            Divider(
              thickness: 2,
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Text("Add ingredienses"),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFieldWidget(
                      labelText: "Ingredient name",
                      controller: _ingredientNameController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFieldWidget(
                              labelText: "Amount",
                              controller: _ingredientAmountController,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Container(
                              padding:
                                  EdgeInsets.only(left: 25, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(width: 0.5)),
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                    labelText:
                                        _selectedUnit != null ? null : 'Unit',
                                    border: InputBorder.none),
                                value: _selectedUnit,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedUnit = newValue;
                                  });
                                },
                                items: <String>[
                                  'kg',
                                  'hg',
                                  'g',
                                  'L',
                                  'dl',
                                  'cl',
                                  'ml',
                                  'msk',
                                  'tsk',
                                  'krm'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(onPressed: () {}, child: Text("Create recipe"))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
