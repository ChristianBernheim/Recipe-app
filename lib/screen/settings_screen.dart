import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/model/user.dart';
import 'package:recipe_app/screen/family_screen.dart';
import 'package:recipe_app/services/firestore_service.dart';
import 'package:recipe_app/theme/theme_provider.dart';
import 'package:recipe_app/components/settings_tile.dart';
import 'package:recipe_app/components/title_tile.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final db = FireStoreService();
    var isDark = Theme.of(context).brightness == Brightness.dark;
    final currentUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            TitleTile(title: "Settings"),
            StreamBuilder<UserModel>(
                stream: db.getUserStream(currentUser!.email),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    final user = snapshot.data;
                    return Column(
                      children: [
                        Text("${user!.firstname} ${user.lastname}"),
                        ElevatedButton(
                            onPressed: () {}, child: Text("Edit profile"))
                      ],
                    );
                  } else {
                    return Text(snapshot.error.toString());
                  }
                })),
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
              iconName: Icons.group,
              title: "Family",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FamilyScreen()),
                );
              },
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
        ),
      ),
    );
  }
}
