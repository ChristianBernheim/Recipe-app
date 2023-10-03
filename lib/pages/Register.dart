import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0x000000),
        body: Container(
            alignment: Alignment.center,
            child: Stack(
              children: [
                Text("Pung"),
                Text("data", style: TextStyle(fontSize: 24))
              ],
            )));
  }
}
