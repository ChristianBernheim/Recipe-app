// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:recipe_app/components/title_tile.dart';
// import 'package:recipe_app/model/family.dart';
// import 'package:recipe_app/services/firestore_user.dart';

// class FamilyMembersDialog extends StatelessWidget {
//   const FamilyMembersDialog({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final db = FireStoreService();
    
//     final currentUser = FirebaseAuth.instance.currentUser;
//     return Padding(
//       padding: const EdgeInsets.all(25),
//       child: Container(
//         alignment: Alignment.center,
//         width: MediaQuery.of(context).size.width - 50,
//         height: MediaQuery.of(context).size.height - 50,
//         padding: EdgeInsets.all(25),
//         decoration: BoxDecoration(
//             color: Theme.of(context).colorScheme.background,
//             borderRadius: BorderRadius.circular(20)),
//         child: Scaffold(
//           backgroundColor: Theme.of(context).colorScheme.background,
//           body: Column(
//             children: [TitleTile(title: "Family Members"),
//             StreamBuilder<FamilyModel>(stream: db.getFamilyStream(currentFamily!.id), builder: builder)],
//           ),
//         ),
//       ),
//     );
//   }
// }
