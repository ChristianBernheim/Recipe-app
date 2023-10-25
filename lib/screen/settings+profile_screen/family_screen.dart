/*******Notes *******/
//Merge this with home_screen, are going to be the same.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/components/title_tile.dart';
import 'package:recipe_app/model/user.dart';
import 'package:recipe_app/screen/settings+profile_screen/create_family_dialog.dart';
import 'package:recipe_app/services/firestore_service.dart';

class FamilyScreen extends StatefulWidget {
  const FamilyScreen({super.key});

  @override
  State<FamilyScreen> createState() => _FamilyScreenState();
}

class _FamilyScreenState extends State<FamilyScreen> {
  // void displayFamilyMembers() {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return FamilyMembersDialog();
  //       });
  // }
  void createFamily(UserModel user) {
    showDialog(
        context: context,
        builder: (context) {
          return CreateFamilyDialog(user: user);
        });
  }

  @override
  Widget build(BuildContext context) {
    final db = FireStoreService();
    final currentUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          padding: EdgeInsets.all(25),
          child: Column(children: [
            TitleTile(
              title: "Family",
            ),
            StreamBuilder<UserModel>(
                stream: db.getUserStream(currentUser!.email),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    final user = snapshot.data;
                    if (user!.familyId != null) {
                      return StreamBuilder(
                          stream: db.getFamilyStream(user.familyId),
                          builder: ((context, snapshot) {
                            if (snapshot.hasData) {
                              final family = snapshot.data;
                              return Column(
                                children: [
                                  Text(family!.name),
                                  StreamBuilder<List<UserModel?>>(
                                      stream:
                                          db.getAllUsersInFamily(user.familyId),
                                      builder: ((context, snapshot) {
                                        if (snapshot.hasData) {
                                          var familyMemberList = snapshot.data;

                                          return ListView.builder(
                                              shrinkWrap: true,
                                              itemCount:
                                                  familyMemberList!.length,
                                              itemBuilder: (context, index) {
                                                var familyMember =
                                                    familyMemberList[index]!;
                                                return Container(
                                                  alignment: Alignment.center,
                                                  width: double.infinity,
                                                  height: 100,
                                                  child: Text(
                                                      "Name: ${familyMember.firstname} ${familyMember.lastname}"),
                                                );
                                              });
                                        } else {
                                          return Text(
                                              "Error: ${snapshot.error.toString()}");
                                        }
                                      })),
                                ],
                              );
                            } else {
                              return Text(
                                  "Error: ${snapshot.error.toString()}");
                            }
                          }));
                    } else {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Looks like you got no family"),
                          Wrap(direction: Axis.horizontal, children: [
                            ElevatedButton(
                              onPressed: () {},
                              child: Text("Join a family"),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                createFamily(user);
                              },
                              child: Text("Create a family"),
                            ),
                          ])
                        ],
                      );
                    }
                  } else {
                    return Text(snapshot.error.toString());
                  }
                })),
          ]),
        ));
  }
}
