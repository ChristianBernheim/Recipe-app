import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/components/recipe_tile.dart';
import 'package:recipe_app/components/title_tile.dart';
import 'package:recipe_app/model/recipe.dart';

class WeeklyFoodListTile extends StatelessWidget {
  WeeklyFoodListTile(
      {this.foodPicture,
      required this.title,
      this.cookTime,
      required this.weekday,
      super.key});

  String? foodPicture;
  String title;
  String? cookTime;
  String weekday;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        width: MediaQuery.of(context).size.width - 50,
        height: MediaQuery.of(context).size.height / 3.3,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              alignment: Alignment.bottomCenter,
              child: Text(
                weekday,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            Stack(children: [
              Center(
                //child: Image.network(foodPicture!, fit: BoxFit.contain),
                child: Image(
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    image: NetworkImage(foodPicture!)),
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.only(
                      top: 40, bottom: 40, left: 30, right: 30),
                  color:
                      Theme.of(context).colorScheme.background.withOpacity(0.7),
                  child: Center(
                    child: Column(children: [
                      Text(
                        title,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            overflow: TextOverflow.ellipsis,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Time to cook: ${cookTime!} min",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ]),
                  ),
                ),
              )
            ]),
          ],
        ),
      ),
    );
  }
}
