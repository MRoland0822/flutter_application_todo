import 'package:flutter/material.dart';

class TodoItem {
  String task;
  String? description;
  bool completed;
  Color color;

  TodoItem({
    required this.task,
    this.description,
    this.completed = false,
    required this.color});
}
