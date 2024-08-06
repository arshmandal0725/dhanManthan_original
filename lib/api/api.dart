import 'package:dhanmanthan_original/models/debt.dart';
import 'package:dhanmanthan_original/models/expense.dart';
import 'package:dhanmanthan_original/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class API {
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

  Future createExpense(Expense exp) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('expenses')
        .add(exp.toJson());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getUserExpense(TheUser chatUser) {
    return firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('expenses')
        .snapshots();
  }

  Future createDebt(Debt debt) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('debt')
        .add(debt.toJson());
  }

 Future<List<Expense>> fetchUserExpense() async {
  try {
    final querySnapshot = await firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('expenses')
        .get();

    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      final date = data['date'];
      DateTime dateTime;

      // Check if the date is a Timestamp or a String
      if (date is Timestamp) {
        dateTime = date.toDate();
      } else if (date is String) {
        dateTime = DateTime.parse(date);
      } else {
        // Handle unexpected date formats
        dateTime = DateTime.now(); // or set a default date
      }

      return Expense(
        title: data['title'] ?? '',
        amount: data['amount'] ?? 0.0,
        date: dateTime,
        category: Category.values.firstWhere(
          (e) => e.toString().split('.').last == data['category'],
          orElse: () => Category.food, // default value if not found
        ),
      );
    }).toList();
  } catch (e) {
    print("Error fetching expenses: $e");
    return [];
  }
}


  Future<List<Debt>> fetchUserDebts() async {
  try {
    final querySnapshot = await firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('debt')
        .get();

    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      final date = data['date'];
      DateTime dateTime;

      // Check if the date is a Timestamp or a String
      if (date is Timestamp) {
        dateTime = date.toDate();
      } else if (date is String) {
        dateTime = DateTime.parse(date);
      } else {
        // Handle unexpected date formats
        dateTime = DateTime.now(); // or set a default date
      }

      return Debt(
        title: data['title'] ?? '',
        amount: data['amount'] ?? 0.0,
        date: dateTime,
        category: Catgory.values.firstWhere(
          (e) => e.toString().split('.').last == data['category'],
          orElse: () => Catgory.minus,
        ),
      );
    }).toList();
  } catch (e) {
    print("Error fetching debts: $e");
    return [];
  }
}

}
