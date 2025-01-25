import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  Future addUser(String userId, Map<String, dynamic> userInfoMap){
    return FirebaseFirestore.instance.collection("User").doc(userId).set(userInfoMap);
  }
}