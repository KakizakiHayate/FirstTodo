final class TodoItem {
  String id;
  String title;
  bool isCompleted;

  TodoItem({required this.id, required this.title, this.isCompleted = false});
}