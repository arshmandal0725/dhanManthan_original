import 'package:dhanmanthan_original/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class API{
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
 

  Future<bool> userExists() async {
    return (await firestore
            .collection('users')
            .doc(firebaseAuth.currentUser!.uid)
            .get())
        .exists;
  }

  Future createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final chatUser = TheUser(
        id: firebaseAuth.currentUser!.uid,
        name: firebaseAuth.currentUser!.displayName.toString(),
        email: firebaseAuth.currentUser!.email.toString(),
        about: "Hey, I'm using We Chat!",
        image: firebaseAuth.currentUser!.photoURL.toString(),
        createdAt: time,
        isOnline: false,
        lastLogin: time,
        pushToken: "");
    return await firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .set(chatUser.toJson());
  }

  Future<void> updateUserData(TheUser currentUser) async {
    await firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .update({'Name': currentUser.name, 'About': currentUser.about});
  }
  
  Stream<QuerySnapshot<Map<String, dynamic>>> getUserinfo(TheUser chatUser) {
    return firestore
        .collection('users')
        .where('id', isEqualTo: chatUser.id)
        .snapshots();
  }

  
  
}
