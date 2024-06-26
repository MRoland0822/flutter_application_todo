import 'package:flutter/material.dart';

class TodoItem {
  String task;
  String? description;
  bool completed;
  Color color;
  DateTime startDate;
  DateTime endDate;
  bool allDay;

  TodoItem({
    required this.task,
    this.description,
    this.completed = false,
    required this.color,
    required this.startDate,
    required this.endDate,
    this.allDay = false,});
}
