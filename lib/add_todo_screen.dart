import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class AddTodoScreen extends StatefulWidget {
  final Function(String, String?, Color) addTodoItem;

  const AddTodoScreen({super.key, required this.addTodoItem});

  @override
  AddTodoScreenState createState() => AddTodoScreenState();
}

class AddTodoScreenState extends State<AddTodoScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  Color pickerColor = Colors.blue; // Default color
  //Color currentColor = Colors.blue;

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
                setState(() =>  pickerColor);
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
              onPressed: showColorPickerDialog,
              child: const Text('Pick a Color'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                widget.addTodoItem(
                  titleController.text,
                  descriptionController.text.isNotEmpty ? descriptionController.text : null,
                  pickerColor,
                );
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
