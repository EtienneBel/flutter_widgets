import 'package:flutter/material.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My ToDos', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1690F8),
      ),
      body: MyTodo.todos.isEmpty
          ? const Center(
              child: Text('Nothing to do !', style: TextStyle(fontSize: 20)))
          : ListView.builder(
              itemCount: MyTodo.todos.length,
              itemBuilder: (context, index) {
                final todo = MyTodo.todos[index];
                return TodoItem(
                    todo: todo,
                    onChanged: (value) {
                      setState(() {
                        MyTodo.todos[index].completed = value;
                      });
                    });
              }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF1690F8),
        foregroundColor: const Color(0xFFFFFFFF),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TodoItem extends StatelessWidget {
  final MyTodo todo;
  final Function(bool) onChanged;

  const TodoItem({super.key, required this.todo, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(todo.name),
      subtitle: Text('Priority : ${todo.priority.name}'),
      value: todo.completed,
      onChanged: (value) {
        onChanged(value!);
      },
    );
  }
}

class MyTodo {
  int id;
  String name;
  bool completed;
  TodoPriority priority;

  MyTodo({
    required this.id,
    required this.name,
    this.completed = false,
    required this.priority,
  });

  static List<MyTodo> todos = [];
}

enum TodoPriority { low, medium, high }
