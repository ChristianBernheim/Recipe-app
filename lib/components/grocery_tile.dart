import 'package:flutter/material.dart';
import 'package:recipe_app/components/title_tile.dart';

class GroceryTile extends StatelessWidget {
  GroceryTile({
    Key? key,
    required this.groceryPickedUp,
    required this.onChanged,
    required this.title,
    required this.amount,
    required this.unit,
  }) : super(key: key);

  final bool groceryPickedUp;
  final ValueChanged<bool?>? onChanged;
  final String title;
  final int amount;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            onChanged?.call(!groceryPickedUp);
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: groceryPickedUp
                ? Colors.greenAccent
                : Theme.of(context).colorScheme.tertiary.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              //Get 2 text and place them at start and at end?
              child: Row(
                children: [
                  Text("$title",
                      style: TextStyle(
                        color: groceryPickedUp
                            ? Colors.green
                            : Theme.of(context).colorScheme.secondary,
                        decoration: groceryPickedUp
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        fontSize: 20,
                      )),
                  Text("${amount.toString()} $unit",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: groceryPickedUp
                            ? Colors.green
                            : Theme.of(context).colorScheme.secondary,
                        decoration: groceryPickedUp
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        fontSize: 20,
                      )),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 5)
      ],
    );
  }
}
