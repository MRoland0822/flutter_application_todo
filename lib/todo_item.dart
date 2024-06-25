class TodoItem {
  String task;
  String? description;
  bool completed;

  TodoItem({required this.task, this.description, this.completed = false});
}
