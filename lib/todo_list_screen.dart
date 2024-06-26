import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'todo_item.dart';
import 'add_todo_screen.dart';
import 'edit_todo_screen.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  TodoListScreenState createState() => TodoListScreenState();
}

class TodoListScreenState extends State<TodoListScreen> {
  final List<TodoItem> _todoItems = [
    TodoItem(
      task: 'Sample Task 1',
      description: 'This is a sample task',
      color: Colors.red,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(hours: 1)),
      allDay: false,
    ),
    TodoItem(
      task: 'Sample Task 2',
      description: 'This is another sample task',
      color: Colors.green,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(hours: 2)),
      allDay: true,
    ),
  ];

  void _addTodoItem(String task, String? description, Color color, DateTime startDate, DateTime endDate, bool allDay) {
    if (task.isNotEmpty) {
      setState(() {
        _todoItems.add(TodoItem(
          task: task,
          description: description,
          color: color,
          startDate: startDate,
          endDate: endDate,
          allDay: allDay,
          ));
      });
    }
  }

  void _editTodoItem(int index, String newTask, String newDescription, Color newColor, DateTime newStartDate, DateTime newEndDate, bool newAllDay) {
    if (newTask.isNotEmpty) {
      setState(() {
        _todoItems[index] = TodoItem(
          task: newTask,
          description: newDescription,
          completed: _todoItems[index].completed,
          color: newColor,
          startDate: newStartDate,
          endDate: newEndDate,
          allDay: newAllDay,
        );
      });
    }
  }

  void _toggleTodoItem(int index) {
    setState(() {
      _todoItems[index].completed = !_todoItems[index].completed;
    });
  }

  void _deleteTodoItem(int index) {
    setState(() {
      _todoItems.removeAt(index);
    });
  }

  void _pushAddTodoScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return AddTodoScreen(addTodoItem: _addTodoItem);
        },
      ),
    );
  }

  void _pushEditTodoScreen(int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return EditTodoScreen(
            initialTitle: _todoItems[index].task,
            initialDescription: _todoItems[index].description ?? '',
            initialColor: _todoItems[index].color,
            initialStartDate: _todoItems[index].startDate,
            initialEndDate: _todoItems[index].endDate,
            initialAllDay: _todoItems[index].allDay,
            updateTodoItem: (newTask, newDescription, newColor, newStartDate, newEndDate, newAllDay) {
              _editTodoItem(index, newTask, newDescription, newColor, newStartDate, newEndDate, newAllDay);
            },
          );
        },
      ),
    );
  }

  Widget _buildTodoList() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Determine the number of columns based on screen width
    int columns;
    if (screenWidth > 1200) {
      columns = 4;
    } else if (screenWidth > 800) {
      columns = 3;
    } else {
      columns = 2;
    }

    // Determine the text size based on screen height
    double titleFontSize;
    double descriptionFontSize;
    if (screenHeight > 1200) {
      titleFontSize = 20.0;
      descriptionFontSize = 16.0;
    } else if (screenHeight > 800) {
      titleFontSize = 18.0;
      descriptionFontSize = 14.0;
    } else {
      titleFontSize = 16.0;
      descriptionFontSize = 12.0;
    }

    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns, // Number of columns
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 1, // To make the cards square
      ),
      itemCount: _todoItems.length,
      itemBuilder: (context, index) {
        return _buildTodoItem(_todoItems[index], index, titleFontSize, descriptionFontSize);
      },
    );
  }

 Widget _buildTodoItem(TodoItem todoItem, int index, double titleFontSize, double descriptionFontSize) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    elevation: 4.0,
    color: todoItem.color, // Use the color from the todo item
    child: InkWell(
      onTap: () => _pushEditTodoScreen(index),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              todoItem.task,
              style: TextStyle(
                fontSize: titleFontSize + 4, // Increase title font size
                fontWeight: FontWeight.bold,
                color: Colors.white, // Ensure good contrast
                decoration: todoItem.completed ? TextDecoration.lineThrough : null,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Text(
                todoItem.description ?? '',
                style: TextStyle(
                  fontSize: descriptionFontSize + 2, // Increase description font size
                  color: Colors.white70, // Ensure good contrast
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Start: ${DateFormat('MMM d, h:mm a').format(todoItem.startDate)}',
              style: const TextStyle(fontSize: 14, color: Colors.white70), // Increase date font size and color contrast
            ),
            Text(
              'End: ${DateFormat('MMM d, h:mm a').format(todoItem.endDate)}',
              style: const TextStyle(fontSize: 14, color: Colors.white70), // Increase date font size and color contrast
            ),
            if (todoItem.allDay)
              const Text(
                'All Day',
                style: TextStyle(fontSize: 14, color: Colors.white70), // Increase font size and color contrast
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Checkbox(
                  shape: const CircleBorder(),
                  activeColor: Theme.of(context).primaryColor,
                  value: todoItem.completed,
                  onChanged: (bool? value) {
                    _toggleTodoItem(index);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.redAccent),
                  onPressed: () => _deleteTodoItem(index),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO List'),
      ),
      body: _buildTodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _pushAddTodoScreen,
        tooltip: 'Add task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
