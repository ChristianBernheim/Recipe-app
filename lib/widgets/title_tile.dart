// ignore_for_file: file_names

import 'package:flutter/material.dart';

class TitleTile extends StatelessWidget {
  final String title;

  const TitleTile({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 15.0),
        width: double.infinity,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontSize: 32,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
