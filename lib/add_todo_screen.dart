import 'package:flutter/material.dart';

class AddTodoScreen extends StatelessWidget {
  final Function(String, String?) addTodoItem;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();


  AddTodoScreen({super.key, required this.addTodoItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Enter something to do...',
                contentPadding: EdgeInsets.all(16.0),
              ),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                hintText: 'Enter a description...',
                contentPadding: EdgeInsets.all(16.0),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                addTodoItem(titleController.text, descriptionController.text);
                Navigator.pop(context); // Close the add todo screen
              },
              child: const Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}
