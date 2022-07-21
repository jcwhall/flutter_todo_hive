import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/todo.dart';

class TodoProviderHive with ChangeNotifier {
  var box = Hive.box('todo_hive_box');
  List<Todo>? _todos = [];

  Future<void> getTodos() async {
    _todos = box.values.cast<Todo>().toList();
  }

  Future<void> addTodo(Todo todo) async {
    _todos?.add(todo);
    await box.add(todo);
    notifyListeners();
  }

  void updateTodo(Todo todo) {
    todo.save();
    notifyListeners();
  }

  void removeTodo(Todo todo) async {
    final tripToDelete =
        await box.values.firstWhere((element) => element.id == todo.id);
    await tripToDelete.delete();
    _todos?.remove(todo);
    notifyListeners();
  }
}
