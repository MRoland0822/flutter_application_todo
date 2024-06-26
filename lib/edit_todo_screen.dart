import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class EditTodoScreen extends StatefulWidget {
  final String initialTitle;
  final String initialDescription;
  final Color initialColor;
  final Function(String, String, Color) updateTodoItem;

  const EditTodoScreen({
    super.key,
    required this.initialTitle,
    required this.initialDescription,
    required this.initialColor,
    required this.updateTodoItem,
  });

  @override
  _EditTodoScreenState createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  Color pickerColor = Colors.blue;
  Color currentColor = Colors.blue;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _descriptionController = TextEditingController(text: widget.initialDescription);
    pickerColor = widget.initialColor;
    currentColor = widget.initialColor;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  void showColorPickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: pickerColor,
              onColorChanged: changeColor,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Got it'),
              onPressed: () {
                setState(() => currentColor = pickerColor);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
              onPressed: showColorPickerDialog,
              child: const Text('Pick a Color'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                widget.updateTodoItem(
                  _titleController.text,
                  _descriptionController.text,
                  currentColor, // Pass the selected color
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
