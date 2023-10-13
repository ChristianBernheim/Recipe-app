import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final IconData iconName;
  final String title;
  final bool? forwardArrow;
  final Color? textColor;
  final VoidCallback onTap;

  const SettingsTile({
    Key? key,
    required this.iconName,
    required this.title,
    this.forwardArrow,
    this.textColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          iconName,
          color: Theme.of(context).colorScheme.tertiary,
        ),
        title: Text(
          title,
          style: TextStyle(
              color: textColor ?? Theme.of(context).colorScheme.tertiary),
        ),
        trailing: forwardArrow == false
            ? null
            : Icon(Icons.arrow_forward_ios_outlined),
      ),
    );
  }
}
