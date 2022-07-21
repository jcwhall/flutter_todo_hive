// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../provider/todo_provider_hive.dart';
import 'todo_screen.dart';
import '../models/todo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Box todoBox;

  @override
  void initState() {
    super.initState();
    // Get reference to an already opened box
    todoBox = Hive.box('todo_hive_box');
  }

  @override
  Widget build(BuildContext context) {
    //Get the TODOs
    var todos = context.watch<TodoProviderHive>().getTodos();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Hive'),
        elevation: 0,
      ),
      body: todoList(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var newTodo = Todo.newTodo();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TodoScreen(todo: newTodo, isNewTodo: true),
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }

  //This is a seperate widget which contains the LIST of Todo items
  ListView todoList(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.only(top: 0),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: todoBox.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final currentTodo = todoBox.getAt(index);
          return Card(
            color: Colors.yellow,
            child: ListTile(
              // leading: Text(currentTodo.title),
              title: Text(currentTodo.title),
              subtitle: Text(currentTodo.description),
              trailing: Icon(
                Icons.sticky_note_2_outlined,
                color: Colors.pink,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TodoScreen(
                        todo: todoBox.getAt(index), isNewTodo: false),
                  ),
                );
              },
            ),
          );
        });
  }
}
