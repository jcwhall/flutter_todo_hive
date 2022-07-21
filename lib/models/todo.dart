import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';
part 'todo.g.dart';

@HiveType(typeId: 1)
class Todo extends HiveObject {
  @HiveField(0)
  var id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late String description;

  //Constructor
  Todo({
    required this.title,
    required this.description,
  }) {
    //Create a UUID
    const uuid = Uuid();
    id = uuid.v4();
  }

  Todo.newTodo() {
    //Create a UUID
    const uuid = Uuid();
    id = uuid.v4();
    title = '';
    description = '';
  }

  @override
  String toString() {
    return '[' + id + '] Title: ' + title + ', Description: ' + description;
  }

  bool isBlank() {
    if (title.isEmpty && description.isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
