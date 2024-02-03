import 'package:flutter/material.dart';
import 'package:todolist/db/db_file.dart';
import 'package:async/async.dart';
import 'package:todolist/model/task_model.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.init();

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});




  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}




class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //функция, достающая список всех задач из таблицы
  String newTaskTxt = '';

  List<Task> todoList = [];
  List<Widget> get items => todoList.map((item) => format(item)).toList();
  final _formKey = GlobalKey<FormState>();


//функция для вывода задач виджетами
  Widget format(Task task) {
    return Padding(padding: EdgeInsets.all(8.0),
      child: Dismissible(
        key: Key(task.id.toString()),
        onDismissed: (DismissDirection b) {
          DB.delete(Task.destinationTable, task);
          refresh();
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.yellow, width: 1),
            borderRadius: BorderRadius.circular(5),
            color: Colors.black,
            shape: BoxShape.rectangle
          ),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Expanded(
                  child: Text(task.task,
                    style: TextStyle(color: Colors.white, fontSize: 20),

                  ),
                ),
              )
            ],
          )

    ),

      ),
    );
  }
  //создание новой задачи
  _create(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Add a new to-do item"),
            content: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    key: _formKey,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                      }
                      return null;
                      },
                    autofocus: true,
                    decoration: InputDecoration(
                        labelText: "What's the new goal, boss?"),
                    onChanged: (name) {
                      newTaskTxt = name;
                    },
                  )
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () => save(),
                  child: Text('Save'))
            ],
          );
        }
    );
  }
  //сохранение задачи в БД
  void save() async {
    if (newTaskTxt != '') {
      Navigator.of(context).pop();
      Task item = Task(
          task: newTaskTxt,
          creationTime: DateTime.now().toString()
      );

      await DB.insert(Task.destinationTable, item);
      setState(() => newTaskTxt = '');
      refresh();
    }
  }

  void initState(){
      refresh();
      super.initState();
  }
//Обновление локального списка через запрос от БД
  void refresh() async {
    List<Map<String, dynamic>> results = await DB.query(Task.destinationTable);
    todoList = results.map((item) => Task.fromMap(item)).toList();
    setState(() {

    });
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
        onPressed: () => _create(context),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );

  }




}
