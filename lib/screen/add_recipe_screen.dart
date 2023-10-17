import 'package:flutter/material.dart';
import 'package:recipe_app/components/text_field_widget.dart';
import 'package:recipe_app/components/title_tile.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => AddRecipeState();
}

final titleController = TextEditingController();

class AddRecipeState extends State<AddRecipeScreen> {
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
        child: SafeArea(
            child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  "lib/image/food.jpg",
                  fit: BoxFit.contain,
                ),
                TitleTile(title: "Add recipe")
              ],
            ),
            Text("Add title "),
            TextFieldWidget(labelText: "Title", controller: titleController),
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
              width: double.infinity,
              child: Column(
                children: [Text("Add ingredienses")],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
