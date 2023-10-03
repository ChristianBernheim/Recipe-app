import 'package:flutter/material.dart';
import 'package:recipe_app/pages/Register.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterScreen()));
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color(0x0000000),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                // Add your onPressed action here
              },
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // Add your onPressed action here
              },
            ),
            SizedBox(), // This is a placeholder for the FAB
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                // Add your onPressed action here
              },
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                // Add your onPressed action here
              },
            ),
          ],
        ),
      ),
    );
  }
}
