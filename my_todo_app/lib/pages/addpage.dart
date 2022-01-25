import 'package:flutter/material.dart';
import 'package:my_todo_app/databasehelper/tododao.dart';
import 'package:my_todo_app/main.dart';

class AddPage extends StatefulWidget {
  AddPage({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  var todoController = TextEditingController();

  Future<void> save(String todo) async {
    await ToDoDAO().addToDo(todo);
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(252, 119, 83, 15),
        title: const Text(
          "Add To Do",
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
                    hintText: "Write down your goal.",
                    border: OutlineInputBorder()),
              ),
            ),
            OutlinedButton(
              child: Text("Save"),
              onPressed: () {
                save(todoController.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
