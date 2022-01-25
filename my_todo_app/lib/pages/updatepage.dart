import 'package:flutter/material.dart';
import 'package:my_todo_app/classes/todo.dart';
import 'package:my_todo_app/databasehelper/databasehelper.dart';
import 'package:my_todo_app/databasehelper/tododao.dart';

class UpdatePage extends StatefulWidget {
  ToDo todo;

  UpdatePage(this.todo, {Key? key}) : super(key: key);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  var todoController = TextEditingController();

  Future<void> updateToDo(int todo_id, String todo) async {
    await ToDoDAO().updateToDo(todo_id, todo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(252, 119, 83, 15),
        title: const Text(
          "Update To Do",
          style: TextStyle(fontFamily: "times new roman"),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 9,
                controller: todoController,
                decoration: const InputDecoration(
                    hintText:
                        "You can update it here. If you leave it blank, it will go back to how it was.",
                    border: OutlineInputBorder()),
              ),
            ),
            OutlinedButton(
              child: Text("Update"),
              onPressed: () {
                setState(() {
                  updateToDo(widget.todo.todo_id, todoController.text);
                  Navigator.pop(context);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
