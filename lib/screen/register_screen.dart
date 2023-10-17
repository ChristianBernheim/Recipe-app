// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:recipe_app/model/user.dart';
import 'package:recipe_app/repository/user_repository.dart';
import 'package:recipe_app/screen/log_in_screen.dart';
import 'package:recipe_app/components/text_field_widget.dart';
import 'package:recipe_app/components/title_tile.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _dateController = TextEditingController();
  final userRepo = Get.put(UserRepository());
  DateTime pickedDate = DateTime.now();
  List<String> genders = ['Male', 'Female', 'Other'];
  late String _selectedGender = 'Male';

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> createUser(UserModel user) async {
    await userRepo.createUser(user);
  }

  Future<void> signUp() async {
    if (passwordConfirmed()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        final user = UserModel(
            userId: userCredential.user!.uid,
            firstname: _firstnameController.text.trim(),
            lastname: _lastnameController.text.trim(),
            gender: _selectedGender,
            birthday: _dateController.text.trim(),
            email: _emailController.text.trim());

        await createUser(user);
      } catch (e) {
        print("Error: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Text("Namn"),
              Divider(
                thickness: 3,
              ),
              Center(child: TitleTile(title: "Register")),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFieldWidget(
                      labelText: "Firstname",
                      controller: _firstnameController,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextFieldWidget(
                      labelText: "Lastname",
                      controller: _lastnameController,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              TextFieldWidget(
                labelText: "Email",
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      child: TextField(
                        controller: _dateController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFFFFFFF),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.tertiary,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary)),
                            labelText: "Birthdate",
                            labelStyle: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                            )),
                        onTap: () async {
                          pickedDate = (await showDatePicker(
                              context: context,
                              initialDate: pickedDate,
                              firstDate: DateTime(DateTime.now().year - 100),
                              lastDate: DateTime.now()))!;

                          if (pickedDate != null) {
                            setState(() {
                              _dateController.text =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                            });
                          }
                        },
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width / 3),
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      color: Colors.white,
                      child: DropdownButton(
                        items: genders
                            .map(
                              (String gender) => DropdownMenuItem<String>(
                                value: gender,
                                child: Text(gender),
                              ),
                            )
                            .toList(),
                        onChanged: (String? val) {
                          setState(() {
                            _selectedGender = val!;
                          });
                        },
                        value: _selectedGender,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              TextFieldWidget(
                labelText: "Password",
                obscureText: true,
                controller: _passwordController,
              ),
              SizedBox(height: 15),
              TextFieldWidget(
                labelText: "Confirm password",
                obscureText: true,
                controller: _confirmPasswordController,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {
                  signUp();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LogInScreen()),
                  );
                },
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
