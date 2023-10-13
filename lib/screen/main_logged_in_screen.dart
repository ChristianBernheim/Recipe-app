// ignore_for_file: file_names, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:recipe_app/screen/home_screen.dart';

import 'package:recipe_app/screen/register_screen.dart';
import 'package:recipe_app/screen/settings_screen.dart';
import 'package:recipe_app/screen/weekly_foodlist_screen.dart';

class MainLoggedInScreen extends StatefulWidget {
  @override
  MainLoggedInScreenState createState() => MainLoggedInScreenState();
}

class MainLoggedInScreenState extends State<MainLoggedInScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    WeeklyFoodListScreen(),
    RegisterScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        color: Theme.of(context).colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: GNav(
            backgroundColor: Theme.of(context).colorScheme.primary,
            color: Theme.of(context).colorScheme.tertiary,
            activeColor: Theme.of(context).colorScheme.tertiary,
            tabBackgroundColor:
                Theme.of(context).colorScheme.tertiary.withOpacity(0.4),
            gap: 12,
            padding: EdgeInsets.all(16),
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.list,
                text: 'Weekly Food list',
              ),
              GButton(icon: Icons.person_add, text: 'Register'),
              GButton(
                icon: Icons.settings,
                text: 'Settings',
              ),
            ],
            selectedIndex: _currentIndex,
            onTabChange: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
