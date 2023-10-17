import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_app/model/user.dart';

class FireStoreService {
  CollectionReference users = FirebaseFirestore.instance.collection("Users");
  Stream<UserModel> getUserStream(String? email) {
    var userRef = users.where("Email", isEqualTo: email);
    return userRef.snapshots().map((document) {
      var userData = document.docs.first;
      return UserModel.fromSnapshot(
          userData as DocumentSnapshot<Map<String, dynamic>>);
    });
  }
}
