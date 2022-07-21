// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/todo.dart';
import 'provider/todo_provider_hive.dart';

import 'screens/home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  //HIVE
  //Initiate
  await Hive.initFlutter();

  //**NOTE** UNCOMMENT THIS LINE TO DELETE the contents of the box
  //await Hive.deleteBoxFromDisk('todo_hive_box');

  // Registering the adapter
  Hive.registerAdapter(TodoAdapter());

  //Open the box
  await Hive.openBox('todo_hive_box');

  runApp(ChangeNotifierProvider<TodoProviderHive>(
    child: const MyApp(),
    create: (_) => TodoProviderHive(), // Create a new ChangeNotifier object
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Flutter Todo Hive',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const HomeScreen(),
    );
  }
}
