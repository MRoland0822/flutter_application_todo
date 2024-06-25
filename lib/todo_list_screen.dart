import 'package:flutter/material.dart';
import 'todo_item.dart';
import 'add_todo_screen.dart';
import 'edit_todo_screen.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  TodoListScreenState createState() => TodoListScreenState();
}

class TodoListScreenState extends State<TodoListScreen> {
  final List<TodoItem> _todoItems = [];

  void _addTodoItem(String task, String? description) {
    if (task.isNotEmpty) {
      setState(() {
        _todoItems.add(TodoItem(task: task, description: description));
      });
    }
  }

  void _editTodoItem(int index, String newTask, String newDescription) {
    if (newTask.isNotEmpty) {
      setState(() {
        _todoItems[index] = TodoItem(
          task: newTask,
          description: newDescription,
          completed: _todoItems[index].completed,
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
            updateTodoItem: (newTask, newDescription) {
              _editTodoItem(index, newTask, newDescription);
            },
          );
        },
      ),
    );
  }

  Widget _buildTodoList() {
    return ListView.builder(
      itemCount: _todoItems.length,
      itemBuilder: (context, index) {
        return _buildTodoItem(_todoItems[index], index);
      },
    );
  }

  Widget _buildTodoItem(TodoItem todoItem, int index) {
    return ListTile(
      title: Text(
        todoItem.task,
        style: TextStyle(
          decoration: todoItem.completed ? TextDecoration.lineThrough : null,
        ),
      ),
      subtitle: todoItem.description != null ? Text(todoItem.description!) : null,
      leading: Checkbox(
        value: todoItem.completed,
        onChanged: (bool? value) {
          _toggleTodoItem(index);
        },
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _pushEditTodoScreen(index),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _deleteTodoItem(index),
          ),
        ],
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
