import 'package:flutter/material.dart';
import 'package:my_todo_app/classes/todo.dart';
import 'package:my_todo_app/databasehelper/tododao.dart';
import 'package:my_todo_app/pages/addpage.dart';
import 'package:my_todo_app/pages/updatepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<ToDo>> toDoList() async {
    var toDoList = ToDoDAO().allToDo();
    return toDoList;
  }

  Future<void> deleteToDo(int todo_id) async {
    var deleteToDo = ToDoDAO().deleteToDo(todo_id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(252, 119, 83, 15),
        title: const Text(
          "To Do List",
          style: TextStyle(fontFamily: "times new roman"),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add_box_outlined),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddPage()));
            },
          ),
        ],
      ),
      backgroundColor: Color.fromRGBO(102, 215, 209, 15),
      body: FutureBuilder<List<ToDo>>(
        future: toDoList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var todoList = snapshot.data;

            return ListView.builder(
              itemCount: todoList!.length,
              itemBuilder: (context, index) {
                var todo = todoList[index];

                return Padding(
                  padding: const EdgeInsets.only(
                      right: 2.5, left: 2.5, top: 0.1, bottom: 0.1),
                  child: SizedBox(
                    // height: 75,
                    child: Card(
                      color: Color.fromRGBO(242, 239, 234, 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.5)),
                      shadowColor: Colors.black,
                      elevation: 7.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: SizedBox(
                              width: 250,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: Text(
                                  todo.todo,
                                  maxLines: 9,
                                  softWrap: true,
                                  textWidthBasis: TextWidthBasis.parent,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "times new roman"),
                                ),
                              ),
                            ),
                          ),
                          //const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: PopupMenuButton(
                              child: const Icon(Icons.dehaze),
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: 1,
                                  child: Text("Delete"),
                                ),
                                const PopupMenuItem(
                                  value: 2,
                                  child: Text("Update"),
                                ),
                              ],
                              onSelected: (value) {
                                if (value == 1) {
                                  setState(() {
                                    deleteToDo(todo.todo_id);
                                  });
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UpdatePage(todo)));
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text("Opps! I guess something went wrong. I'm sorry!"),
            );
          }
        },
      ),
    );
  }
}
