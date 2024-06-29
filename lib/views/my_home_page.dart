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
        title: Text('ToDo List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      labelText: 'Add a new task',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if (_textController.text.isNotEmpty) {
                      todoListNotifier.addTodoItem(_textController.text);
                      _textController.clear();
                    }
                  },
                ),
              ],
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