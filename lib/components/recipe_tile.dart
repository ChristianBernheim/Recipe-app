import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  final String title;
  final String? cookTime;
  final String? recipeImage;

  const RecipeCard(
      {super.key, required this.title, this.cookTime, this.recipeImage});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: (Color.fromARGB(10, 255, 255, 255)),
      child: Container(
        width: 150,
        child: Column(
          children: [
            Container(
              height: 100,
              width: double.infinity,
              child: recipeImage != null
                  ? Image.network(
                      recipeImage!,
                      fit: BoxFit.cover,
                    )
                  : Icon(
                      Icons.fastfood,
                      color: Theme.of(context).colorScheme.tertiary,
                      size: 50,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: cookTime != "unkown"
                    ? Text(
                        "Time to cook: ${cookTime} min",
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      )
                    : Text("No given time")),
          ],
        ),
      ),
    );
  }
}
