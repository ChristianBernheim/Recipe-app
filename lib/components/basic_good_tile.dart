// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class BasicGoodTile extends StatelessWidget {
  BasicGoodTile(
      {super.key,
      required this.onChanged,
      required this.missingItem,
      required this.basicGood});
  Function(bool?)? onChanged;
  final bool missingItem;
  final String basicGood;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 300,
      padding: EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
      ),
      child: Wrap(
        direction: Axis.horizontal,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Checkbox(value: missingItem, onChanged: onChanged),
          Text(basicGood)
        ],
      ),
    );
  }
}
