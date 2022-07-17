import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f1list/models/todo_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class DatabaseService {
  final user = FirebaseAuth.instance.currentUser;
  final _firebaseInstance = FirebaseFirestore.instance;

  addToDoItem(TodoItem todoItem) async {
    final _docRef = _firebaseInstance
        .collection('users')
        .doc(user!.uid)
        .collection('user_todos')
        .doc();
    todoItem.id = _docRef.id;
    try {
      await _docRef.set(todoItem.toJson());
      print('todo added');
    } catch (e) {
      throw e.toString();
    }
  }

  deleteTodo(String todoId) async {
    final _docRef = _firebaseInstance
        .collection('users')
        .doc(user!.uid)
        .collection('user_todos')
        .doc(todoId);
    try {
      await _docRef.delete();
    } catch (e) {
      throw e.toString();
    }
  }

  updateTodo(String todoId, Map<String, String> udpateField) async {
    final _docRef = _firebaseInstance
        .collection('users')
        .doc(user!.uid)
        .collection('user_todos')
        .doc(todoId);
    try {
      await _docRef.update(udpateField);
    } catch (e) {
      throw e.toString();
    }
  }
}
