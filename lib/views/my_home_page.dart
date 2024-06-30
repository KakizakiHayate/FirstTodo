import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/todo_item.dart';
import '../providers/providers.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoList = ref.watch(todoListProvider);
    final todoListNotifier = ref.read(todoListProvider.notifier);
    final TextEditingController _textController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('タスク一覧'),
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
      ),
      body: Column(
        children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search, size: 24),
                      prefixIconColor: Color(0xFF45A182),
                      hintText: 'タスクを検索する',
                      hintStyle: TextStyle(color: Color(0xFF45A182), fontSize: 16.0),
                      fillColor: Color(0xFFE5F5F0),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none
                      ),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
          Expanded(
            child: ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (context, index) {
                final item = todoList[index];
                return Dismissible(
                  key: Key(item.id),
                  onDismissed: (direction) {
                    todoListNotifier.removeTodoItem(item.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Task "${item.title}" dismissed')));
                  },
                  child: ListTile(
                    title: Text(item.title),
                    leading: Checkbox(
                      value: item.isCompleted,
                      onChanged: (value) {
                        todoListNotifier.toggleTodoItem(item.id);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}