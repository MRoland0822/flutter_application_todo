import 'package:flutter/material.dart';

class EditTodoScreen extends StatefulWidget {
  final String initialTitle;
  final String initialDescription;
  final Function(String, String) updateTodoItem;

  const EditTodoScreen({
    super.key,
    required this.initialTitle,
    required this.initialDescription,
    required this.updateTodoItem,
  });

  @override
  // ignore: library_private_types_in_public_api
  _EditTodoScreenState createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _descriptionController = TextEditingController(text: widget.initialDescription);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                widget.updateTodoItem(
                  _titleController.text,
                  _descriptionController.text,
                );
                Navigator.pop(context);
              },
              child: const Text('Update Todo'),
            ),
          ],
        ),
      ),
    );
  }
}