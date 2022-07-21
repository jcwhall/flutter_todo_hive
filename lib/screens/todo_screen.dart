import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/todo_provider_hive.dart';
import '../models/todo.dart';

class TodoScreen extends StatefulWidget {
  TodoScreen({Key? key, required this.todo, required this.isNewTodo})
      : super(key: key);

  final Todo todo;
  final bool isNewTodo;

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    titleController.text = widget.todo.title;
    descriptionController.text = widget.todo.description;

    //Used to save the information on the page when going back
    return WillPopScope(
        onWillPop: () {
          widget.todo.title = titleController.text;
          widget.todo.description = descriptionController.text;

          //Check if the Todo is new
          if (widget.isNewTodo) {
            //Check if the Todo is blank
            if (widget.todo.isBlank() == false) {
              //Not blank, so ADD the Todo
              context.read<TodoProviderHive>().addTodo(widget.todo);
            }
          } else {
            //Update the Todo
            context.read<TodoProviderHive>().updateTodo(widget.todo);
          }

          Navigator.pop(context);
          return Future.value(false);
        },
        child: Scaffold(
            appBar: AppBar(
              title: Icon(
                Icons.sticky_note_2_outlined,
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    //Check if the Todo already exists, thus needs to be deleted
                    //If it's a new Todo, it does NOT need to be deleted, just navigate back (pop)
                    if (widget.isNewTodo == false) {
                      //Remove Todo
                      context.read<TodoProviderHive>().removeTodo(widget.todo);
                      //Display snackbar
                      final snackBar = SnackBar(
                          content: const Text('Todo removed'),
                          action: SnackBarAction(
                            label: 'dismiss',
                            onPressed: () {},
                          ),
                          duration: const Duration(seconds: 1));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    //Or just Return
                    Navigator.pop(context);
                  },
                )
              ],
            ),
            body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: "Title",
                        border: UnderlineInputBorder(),
                      ),
                      autofocus: true,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: TextFormField(
                      minLines: 6,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: descriptionController,
                      decoration: InputDecoration(
                        labelText: "Description",
                        border: OutlineInputBorder(),
                      ),
                      autofocus: true,
                    ),
                  )
                ])));
  }
}
