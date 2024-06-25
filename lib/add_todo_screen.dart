import 'package:flutter/material.dart';

class AddTodoScreen extends StatelessWidget {
  final Function(String, String?, Color) addTodoItem;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final Color selectedColor = Colors.blue;

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
                labelText: 'Title',
                hintText: 'Enter something to do...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'Enter a description...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
              addTodoItem(titleController.text, descriptionController.text.isNotEmpty ? descriptionController.text : null, selectedColor);
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
