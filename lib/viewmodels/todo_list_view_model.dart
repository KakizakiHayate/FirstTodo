import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../models/todo_item.dart';

class TodoListViewModel extends StateNotifier<List<TodoItem>> {
  TodoListViewModel() : super([]);

  final _uuid = Uuid();

  void addTodoItem(String title) {
    state = [
      ...state,
      TodoItem(id: _uuid.v4(), title: title),
    ];
  }

  void toggleTodoItem(String id) {
    state = [
      for (final item in state)
        if (item.id == id)
          TodoItem(
            id: item.id,
            title: item.title,
            isCompleted: !item.isCompleted,
          )
        else
          item,
    ];
  }

  void removeTodoItem(String id) {
    state = state.where((item) => item.id != id).toList();
  }
}