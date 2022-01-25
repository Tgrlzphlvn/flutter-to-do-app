import 'package:my_todo_app/classes/todo.dart';
import 'package:my_todo_app/databasehelper/databasehelper.dart';

class ToDoDAO {
  Future<List<ToDo>> allToDo() async {
    var db = await DatabaseHelper.databaseAccess();

    List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM todolist");

    return List.generate(maps.length, (index) {
      var line = maps[index];

      return ToDo(todo_id: line["todo_id"], todo: line["todo"]);
    });
  }

  Future<void> addToDo(String todo) async {
    var db = await DatabaseHelper.databaseAccess();

    var data = Map<String, dynamic>();
    data["todo"] = todo;

    await db.insert("todolist", data);
  }

  Future<void> updateToDo(int todo_id, String todo) async {
    var db = await DatabaseHelper.databaseAccess();

    var data = Map<String, dynamic>();
    data["todo"] = todo;

    await db
        .update("todolist", data, where: "todo_id =?", whereArgs: [todo_id]);
  }

  Future<void> deleteToDo(int todo_id) async {
    var db = await DatabaseHelper.databaseAccess();

    await db.delete("todolist", where: "todo_id =?", whereArgs: [todo_id]);
  }
}
