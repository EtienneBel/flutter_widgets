import 'package:flutter/material.dart';
import 'package:state_manag_with_provider/todo_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Todo app',
      debugShowCheckedModeBanner: false,
      home: TodoPage(),
    );
  }
}
