import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/components/camera_or_library_tile.dart';
import 'package:recipe_app/model/user.dart';
import 'package:recipe_app/screen/settings+profile_screen/edit_profile.dart';
import 'package:recipe_app/screen/settings+profile_screen/family_screen.dart';
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
  void CameraOrLibary(UserModel user) {
    showDialog(
        context: context,
        builder: (context) {
          return CameraOrLibraryTile(user: user);
        });
  }

  @override
  Widget build(BuildContext context) {
    final db = FireStoreService();
    var isDark = Theme.of(context).brightness == Brightness.dark;
    final currentUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                        GestureDetector(
                          onTap: () {
                            CameraOrLibary(user);
                          },
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      width: 3),
                                ),
                                child: user!.profilePicture != null
                                    ? ClipOval(
                                        child: Image.network(
                                          user.profilePicture!,
                                          fit: BoxFit.cover,
                                          width: 150,
                                          height: 150,
                                        ),
                                      )
                                    : Icon(
                                        Icons.person,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        size: 150,
                                      ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 8, right: 10),
                                child: Icon(
                                  Icons.edit,
                                  size: 30,
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4, bottom: 4),
                          child: Text(
                            "${user.firstname} ${user.lastname}",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EditProfileScreen(user: user)),
                              );
                            },
                            child: Text("Edit profile"))
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
                iconName: Icons.receipt, title: "Recipe", onTap: () {}),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Divider(
                thickness: 3,
                color: Theme.of(context).colorScheme.tertiary.withOpacity(0.7),
              ),
            ),
            SettingsTile(
                iconName: Icons.feedback, title: "Feedback", onTap: () {}),
            SettingsTile(
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
              iconName: Icons.logout,
              title: "Logout",
              forwardArrow: false,
              textColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
