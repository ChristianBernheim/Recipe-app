import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:recipe_app/components/error_empty_field_dialog.dart';
import 'package:recipe_app/components/ingredient_tile.dart';
import 'package:recipe_app/components/text_field_widget.dart';
import 'package:recipe_app/components/title_tile.dart';
import 'package:recipe_app/model/ingredient.dart';
import 'package:recipe_app/model/ingredient_amount.dart';
import 'package:recipe_app/model/recipe.dart';
import 'package:recipe_app/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CreateRecipeScreen extends StatefulWidget {
  const CreateRecipeScreen({super.key});

  @override
  State<CreateRecipeScreen> createState() => CreateRecipeState();
}

class CreateRecipeState extends State<CreateRecipeScreen> {
  final db = FireStoreService();
  final currentUser = FirebaseAuth.instance.currentUser;
  FirebaseStorage _storage = FirebaseStorage.instance;
  List<IngredientAmountModel> ingredientAmountList = [];
  List<IngredientWidget> ingredientWidgets = [];
  List<String> userMethodSteps = [];
  String? _selectedUnit;
  String? recipePicture;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _ingredientAmountController = TextEditingController();
  TextEditingController _ingredientNameController = TextEditingController();
  TextEditingController _cookTimeController = TextEditingController();
  TextEditingController _howToController = TextEditingController();

  Future<List<IngredientModel>> _getIngredients(String pattern) async {
    return await db.getIngredientsByPartialName(pattern);
  }

  void _uploadImage(String path) async {
    if (path == null) return;

    try {
      Reference ref = _storage
          .ref()
          .child('recipe_images/${DateTime.now().millisecondsSinceEpoch}');

      final result = await ref.putFile(File(path));
      String fileUrl = await result.ref.getDownloadURL();
      print('Uploaded image URL: $fileUrl'); // Debugging line

      setState(() {
        recipePicture = fileUrl;
      });
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
    _uploadImage(file!.path);
  }

  void CameraOrLibary() async {
    await showDialog(
      context: context,
      builder: (context) {
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
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
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
      },
    );
  }

  List<InlineSpan> generateUserMethodSteps() {
    List<InlineSpan> textSpans = [];

    for (int i = 0; i < userMethodSteps.length; i++) {
      textSpans.add(
        TextSpan(
          text: '${i + 1}. ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );

      textSpans.add(
        TextSpan(
          text: '${userMethodSteps[i]}\n',
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return textSpans;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Theme.of(context).colorScheme.background,
                Theme.of(context).colorScheme.primary,
              ],
            ),
          ),
          child: Column(
            children: [
              Stack(
                children: [TitleTile(title: "Add recipe")],
              ),
              SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () {
                  CameraOrLibary();
                },
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      child: recipePicture != null
                          ? Image.network(recipePicture!)
                          : Icon(
                              Icons.photo_camera,
                              color: Theme.of(context).colorScheme.tertiary,
                              size: 150,
                            ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFieldWidget(
                  labelText: "Title",
                  controller: _titleController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFieldWidget(
                  labelText: "Time to cook (in min)",
                  controller: _cookTimeController,
                  keyboardType: TextInputType.number,
                ),
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
                    Text(
                      "Add ingredients",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0x20FFFFFF),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              width: 0.5,
                              color: Theme.of(context).colorScheme.tertiary,
                            )),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: TypeAheadFormField<IngredientModel>(
                            textFieldConfiguration: TextFieldConfiguration(
                              controller: _ingredientNameController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: Color(0x20FFFFFF),
                                  labelText: "Ingredient name",
                                  labelStyle: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                  )),
                            ),
                            suggestionsCallback: (pattern) async {
                              return await _getIngredients(pattern);
                            },
                            itemBuilder: (context, suggestion) {
                              return ListTile(
                                title: Text(suggestion.name),
                              );
                            },
                            onSuggestionSelected: (suggestion) {
                              _ingredientNameController.text = suggestion.name;
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
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
                                padding: EdgeInsets.only(
                                  left: 25,
                                  top: 5,
                                  bottom: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0x20FFFFFF),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                      width: 0.5,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary),
                                ),
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                      hintText: "Unit",
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary)),
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
                                    'krm',
                                    'st',
                                  ].map<DropdownMenuItem<String>>(
                                    (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        // Add ingredient to the DB
                        if (_ingredientNameController.text != "" ||
                            _ingredientAmountController.text != "" ||
                            _selectedUnit != null) {
                          // Capitalize the first letter of the ingredient name
                          String capitalizedIngredientName =
                              _ingredientNameController.text[0].toUpperCase() +
                                  _ingredientNameController.text.substring(1);
                          String ingredientName = capitalizedIngredientName;
                          double ingredientAmount =
                              double.parse(_ingredientAmountController.text);
                          String? ingredientUnit = _selectedUnit;

                          // Check if the ingredient already exists in the database
                          bool ingredientExists = await db
                              .doesIngredientExist(capitalizedIngredientName);

                          if (ingredientExists == true) {
                            print("Ingredient already exists.");
                          } else {
                            await db.createIngredient(
                              IngredientModel(
                                name: capitalizedIngredientName,
                              ),
                            );

                            ingredientAmountList.add(
                              IngredientAmountModel(
                                ingredientId: ingredientName,
                                amount: ingredientAmount,
                                unit: ingredientUnit ?? "",
                              ),
                            );

                            _ingredientNameController.clear();
                            _ingredientAmountController.clear();

                            setState(() {
                              ingredientWidgets.add(
                                IngredientWidget(
                                  title: capitalizedIngredientName,
                                  amount: ingredientAmount,
                                  measurementUnit: ingredientUnit ?? "",
                                ),
                              );
                            });
                          }
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ErrorEmptyFieldDialog();
                            },
                          );
                        }
                      },
                      child: Text("Add Ingredient"),
                    ),
                    Divider(
                        height: 2,
                        color: Theme.of(context).colorScheme.tertiary),
                    Text(
                      "Ingredients",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontWeight: FontWeight.bold),
                    ),
                    Column(
                      children: ingredientWidgets,
                    ),
                    Divider(
                        height: 2,
                        color: Theme.of(context).colorScheme.tertiary),
                    Text(
                      "Method",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: 300,
                      height: 150,
                      decoration: BoxDecoration(
                          color: Color(0x20FFFFFF),
                          border: Border.all(
                              width: 0.5,
                              color: Theme.of(context).colorScheme.tertiary)),
                      child: TextField(
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary),
                        maxLines: null,
                        controller: _howToController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0x20FFFFFF),
                          labelText: 'Method',
                          hintText: 'Enter your method',
                        ),
                        onChanged: (value) {
                          // Handle the changes in the text field
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        //Check so the textfield isn't empty when button is clicked
                        if (_howToController.text != "") {
                          // Add a step to the userMethodSteps list
                          userMethodSteps.add(_howToController.text);
                          _howToController.clear();
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ErrorEmptyFieldDialog();
                            },
                          );
                        }

                        //
                        setState(() {});
                      },
                      child: Text("Add Step"),
                    ),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary),
                        children: generateUserMethodSteps(),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        String capitalizedtitle =
                            _titleController.text[0].toUpperCase() +
                                _titleController.text.substring(1);
                        RecipeModel recipe = RecipeModel(
                          title: capitalizedtitle,
                          cookTime: _cookTimeController.text,
                          userId: currentUser?.uid ?? "",
                          ingredients: ingredientAmountList,
                          howToMethodList: userMethodSteps,
                          foodPicture: recipePicture,
                        );

                        await db.createRecipe(recipe);
                        Navigator.of(context).pop();
                        // Get user input
                      },
                      child: Text("Create recipe"),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
