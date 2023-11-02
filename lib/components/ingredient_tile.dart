// ignore_for_file: file_names

import 'package:flutter/material.dart';

double halfscreen = double.infinity / 2;

class IngredientWidget extends StatelessWidget {
  final String title;
  final double amount;
  final String measurementUnit;

  const IngredientWidget(
      {super.key,
      required this.title,
      required this.amount,
      required this.measurementUnit});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Text(
                  amount.toString(),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  measurementUnit,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
