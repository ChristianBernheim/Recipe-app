import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  final String title;
  final String description;

  const RecipeCard({super.key, required this.title, this.description = ""});

  @override
  Widget build(BuildContext context) {
    return Card(
      color:
          (Color.fromARGB(10, 255, 255, 255)), // Set the card background color
      margin: EdgeInsets.all(8.0),
      child: Container(
        width: 150, // Adjust the width as needed
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 100, // Adjust the height for the image
              width: double.infinity,

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "lib/image/food.jpg",
                  fit: BoxFit.contain,
                ),
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
            if (description.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  description,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
