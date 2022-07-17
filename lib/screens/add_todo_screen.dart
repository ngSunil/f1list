import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f1list/custom_widgets.dart';
import 'package:f1list/models/todo_model.dart';
import 'package:f1list/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddToDoScreen extends StatefulWidget {
  const AddToDoScreen({super.key});

  @override
  State<AddToDoScreen> createState() => _AddToDoScreenState();
}

class _AddToDoScreenState extends State<AddToDoScreen> {
  final TextEditingController _todoTitleController = TextEditingController();
  final TextEditingController _todoDescriptionController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Todo')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            // ------------ TODO TITLE -------------
            TextFormField(
              controller: _todoTitleController,
              style: const TextStyle(fontSize: 18),
              validator: (value) {
                if (value!.length < 6) {
                  return 'Title Required';
                }
                return null;
              },
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter Todo Title',
                isDense: true,
              ),
            ),

            SizedBox(height: 20),
            // ------------ TODO DESCRIPTION -------------
            TextFormField(
              controller: _todoDescriptionController,
              style: const TextStyle(fontSize: 18),
              validator: (value) {
                if (value!.length < 6) {
                  return 'Description is required field';
                }
                return null;
              },
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter Todo Description',
                isDense: true,
              ),
            ),

            // ------------ SAVE BUTTON -------------
            SizedBox(height: 20),
            ElevatedButton.icon(
                onPressed: () async {
                  TodoItem todoItem = TodoItem(
                      title: _todoTitleController.text,
                      description: _todoDescriptionController.text,
                      dateAdded: DateTime.now());
                  try {
                    await DatabaseService().addToDoItem(todoItem);
                    CustomWidgets.showSnackBar(
                        context, "New Todo Added succefully");
                  } catch (e) {
                    CustomWidgets.showSnackBar(context, e.toString());
                  }
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.save),
                label: Text("Save To Do"))
          ]),
        ),
      ),
    );
  }
}
