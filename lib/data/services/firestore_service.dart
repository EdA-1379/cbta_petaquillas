import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class FirestoreService {
  final db = FirebaseFirestore.instance;

  Future<UserModel?> getUser(String uid) async {
    final snap = await db.collection("usuarios").doc(uid).get();
    if (!snap.exists) return null;
    return UserModel.fromMap(snap.data()!, uid);
  }
}
