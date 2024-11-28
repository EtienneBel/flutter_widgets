import 'package:flutter/material.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final _controller = TextEditingController();
  TodoPriority priority = TodoPriority.Normal;

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
        onPressed: () {
          addTodo();
        },
        backgroundColor: const Color(0xFF1690F8),
        foregroundColor: const Color(0xFFFFFFFF),
        child: const Icon(Icons.add),
      ),
    );
  }

  void addTodo() {
    showModalBottomSheet(
      context: context,
      // isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setBuilderState) => Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'What do you want to do ?',
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 25),
                child: Text('Select Priority'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio<TodoPriority>(
                    value: TodoPriority.Low,
                    groupValue: priority,
                    onChanged: (value) {
                      setBuilderState(() {
                        priority = value!;
                      });
                    },
                  ),
                  Text(TodoPriority.Low.name),
                  Radio<TodoPriority>(
                    value: TodoPriority.Normal,
                    groupValue: priority,
                    onChanged: (value) {
                      setBuilderState(() {
                        priority = value!;
                      });
                    },
                  ),
                  Text(TodoPriority.Normal.name),
                  Radio<TodoPriority>(
                    value: TodoPriority.High,
                    groupValue: priority,
                    onChanged: (value) {
                      setBuilderState(() {
                        priority = value!;
                      });
                    },
                  ),
                  Text(TodoPriority.High.name),
                ],
              ),
              ElevatedButton(onPressed: _save, child: const Text('Save'))
            ],
          ),
        ),
      ),
    );
  }

  void _save() {
    if (_controller.text.isEmpty) {
      // print('hi');
      showMsg(context, 'Input field must not be empty');
      return;
    }

    final todo = MyTodo(
      id: DateTime.now().millisecondsSinceEpoch,
      name: _controller.text,
      priority: priority,
    );

    MyTodo.todos.add(todo);
    _controller.clear();
    setState(() {
      Navigator.pop(context);
    });
  }
}

void showMsg(BuildContext context, String s) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Cauti on !'),
            content: Text(s),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              )
            ],
          ));
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

enum TodoPriority { Low, Normal, High }
