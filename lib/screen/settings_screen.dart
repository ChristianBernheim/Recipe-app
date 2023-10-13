// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/theme/theme_provider.dart';
import 'package:recipe_app/widgets/settings_tile.dart';
import 'package:recipe_app/widgets/title_tile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
              child: Column(
            children: [
              TitleTile(title: "Settings"),
              Card(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                child: ListTile(
                    onTap: () {},
                    leading: Icon(
                      isDark ? Icons.light_mode : Icons.dark_mode,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    title: Text(
                      isDark ? "Lightmode" : "Darkmode",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                    trailing: Switch(
                      value: isDark,
                      onChanged: (_isDark) {
                        Provider.of<ThemeProvider>(context, listen: false)
                            .toggleTheme();
                        setState(() {
                          _isDark = isDark;
                        });
                      },
                    )),
              ),
              SettingsTile(
                onTap: () {},
                iconName: Icons.person,
                title: "Account",
              ),
              SettingsTile(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                },
                iconName: Icons.logout,
                title: "Logout",
                forwardArrow: false,
                textColor: Colors.red,
              ),
              Divider(
                thickness: 3,
                color: Theme.of(context).colorScheme.tertiary.withOpacity(0.7),
              )
            ],
          )),
        ));
  }
}
