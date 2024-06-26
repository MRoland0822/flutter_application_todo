import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';

class AddTodoScreen extends StatefulWidget {
  final Function(String, String?, Color, DateTime, DateTime, bool) addTodoItem;

  const AddTodoScreen({super.key, required this.addTodoItem});

  @override
  AddTodoScreenState createState() => AddTodoScreenState();
}

class AddTodoScreenState extends State<AddTodoScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  Color pickerColor = Colors.blue; // Default color
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(hours: 1));
  bool allDay = false;

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

Future<DateTime?> pickDate(BuildContext context, DateTime initialDate) async {
    return await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
  }

  Future<TimeOfDay?> pickTime(BuildContext context, DateTime initialDate) async {
    return await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initialDate),
    );
  }

  Future<void> _selectDateTime(bool isStartDate) async {
    final DateTime initialDate = isStartDate ? startDate : endDate;
    final DateTime? pickedDate = await pickDate(context, initialDate);

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await pickTime(context, pickedDate);

      if (pickedTime != null && mounted) {
        final DateTime pickedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        // Validation for end date
        if (!isStartDate && pickedDateTime.isBefore(startDate)) {
          // Handle error: End date is before start date
          // Show error message or take appropriate action
          return;
        }

        setState(() {
          if (isStartDate) {
            startDate = pickedDateTime;
          } else {
            endDate = pickedDateTime;
          }
        });
      }
    }
  }

  void _addTask() {
    if (titleController.text.isEmpty) {
      // Show a warning dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Invalid Input'),
            content: const Text('Title cannot be empty.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else if (startDate.isAfter(endDate)) {
      // Show a warning dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Invalid Date'),
            content: const Text('Start date must be before end date.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      widget.addTodoItem(
        titleController.text,
        descriptionController.text.isNotEmpty ? descriptionController.text : null,
        pickerColor,
        startDate,
        endDate,
        allDay,
      );
      Navigator.pop(context);
    }
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
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _selectDateTime(true),
                    child: Text('Start: ${DateFormat('MMM d, h:mm a').format(startDate)}'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _selectDateTime(false),
                    child: Text('End: ${DateFormat('MMM d, h:mm a').format(endDate)}'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Checkbox(
                value: allDay,
                onChanged: (bool? value) {
                  setState(() {
                    allDay = value ?? false;
                  });
                },
              ),
              title: const Text('All Day'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addTask,
              child: const Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}