import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  static Stream<QuerySnapshot<Object?>> getUser(String uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .snapshots();
  }
}
