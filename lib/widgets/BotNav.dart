// ignore_for_file: file_names, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:recipe_app/screen/HomeScreen.dart';
import 'package:recipe_app/screen/LogIn.dart';
import 'package:recipe_app/screen/Register.dart';
import 'package:recipe_app/screen/WelcomeScreen.dart';

class BotNavbar extends StatefulWidget {
  @override
  BotNavbarState createState() => BotNavbarState();
}

class BotNavbarState extends State<BotNavbar> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    LogInScreen(),
    RegisterScreen(),
    WelcomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        color: Theme.of(context).colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: GNav(
            backgroundColor: Theme.of(context).colorScheme.primary,
            color: Theme.of(context).colorScheme.background,
            activeColor: Theme.of(context).colorScheme.primary,
            tabBackgroundColor:
                Theme.of(context).colorScheme.background.withOpacity(0.7),
            gap: 12,
            padding: EdgeInsets.all(16),
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.login,
                text: 'Login',
              ),
              GButton(icon: Icons.person_add, text: 'Register'),
              GButton(
                icon: Icons.help,
                text: 'Welcome',
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
