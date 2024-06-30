import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/todo_list_view_model.dart';
import '../models/todo_item.dart';

final todoListProvider = StateNotifierProvider<TodoListViewModel, List<TodoItem>>((ref) {
  return TodoListViewModel();
});