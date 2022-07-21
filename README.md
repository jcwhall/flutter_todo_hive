# flutter-todo-hive
I couldn't find a good example to create a basic Todo app in Flutter using Hive.
This app does the following:
- List Todos
- Create Todo
- View + Update Todo
- Delete Todo

It has been coded for the Web (Chrome) and hasn't been tested on other platforms.

# RUN - In order to run the app:
flutter run

# HIVE (Rebuilding HIVE custom trip adapter)
- If you make any changes to the todo.dart model, you'll need to run the following to regenerate the HIVE adapter (todo.g.dart):
- flutter packages pub run build_runner build