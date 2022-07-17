import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f1list/custom_widgets.dart';
import 'package:f1list/models/todo_model.dart';
import 'package:f1list/screens/add_todo_screen.dart';
import 'package:f1list/services/auth_service.dart';
import 'package:f1list/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late CollectionReference userTodos;
  final user = FirebaseAuth.instance.currentUser;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  Future showEditDialog(DocumentSnapshot todoToUpdate) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: const Text('Update a Todo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {},
                controller: _titleController,
                decoration:
                    const InputDecoration(hintText: "Text Field in Dialog"),
              ),
              TextField(
                onChanged: (value) {},
                controller: _descController,
                decoration:
                    const InputDecoration(hintText: "Text Field in Dialog"),
              ),
              ElevatedButton(
                  onPressed: () {
                    try {
                      DatabaseService().updateTodo(todoToUpdate["id"], {
                        "title": _titleController.text,
                        "description": _descController.text
                      });
                      CustomWidgets.showSnackBar(
                          context, "Data Updated Successfully");
                    } catch (e) {
                      CustomWidgets.showSnackBar(context, e.toString());
                    }
                    Navigator.of(context).pop();
                  },
                  child: const Text("Update"))
            ],
          )));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    CollectionReference userTodos = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('user_todos');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
              onPressed: () => AuthService().signOut(),
              icon: const Icon(
                Icons.exit_to_app,
              ))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .collection('user_todos')
            .snapshots(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? const CircularProgressIndicator()
              : ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot todos = snapshot.data!.docs[index];
                    print(todos);
                    return ListTile(
                      title: Text(todos['title']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                // DatabaseService().updateTodo(
                                //     todos.id, {"title": "new title"})
                                _titleController.text = todos["title"];
                                _descController.text = todos["description"];
                                showEditDialog(todos);
                              },
                              icon: const Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                DatabaseService().deleteTodo(todos["id"]);
                                CustomWidgets.showSnackBar(
                                    context, "Data Deleted Successfully");
                              },
                              icon: const Icon(Icons.delete)),
                        ],
                      ),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddToDoScreen(), fullscreenDialog: true)),
      ),
    );
  }
}
