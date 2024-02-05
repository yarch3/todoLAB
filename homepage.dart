import 'package:flutter/material.dart';

import '../db/db_file.dart';
import '../db/db_service.dart';
import '../model/task_model.dart';
part 'hp_handler.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //функция, достающая список всех задач из таблицы
  String newTaskTxt = '';
  final formKey = GlobalKey<FormState>();
  List<Task> todoList = [];
  List<Widget> get items => todoList.map((item) => TasktoWidget(item)).toList();
  BDService service = BDService();
  initState() {//обновляем todoList при запуске
    refresh();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("To-Do List"),
          backgroundColor: Color.fromRGBO(71, 236, 191, 100)
      ),
      backgroundColor: Colors.black,
      body: Container(//
          child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 10),
                  child: Text("Swipe the task out when it's done!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
                ListView(
                  children: items,
                  shrinkWrap: true,
                )
              ]
          )
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor:Color.fromRGBO(71, 236, 191, 100),
        onPressed: () => createNewTaskForm(),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );

  }




}