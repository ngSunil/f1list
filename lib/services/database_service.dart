import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f1list/models/todo_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final user = FirebaseAuth.instance.currentUser;
  final firebaseInstance = FirebaseFirestore.instance;
  addToDoItem(TodoItem todoItem) async {
    final _newDocRef = firebaseInstance
        .collection('users')
        .doc(user!.uid)
        .collection('user_todos')
        .doc();
    try {
      await _newDocRef.set(todoItem.toJson());
      print('todo added');
    } catch (e) {
      throw e.toString();
    }
  }
}
