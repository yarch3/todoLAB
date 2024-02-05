part of 'homepage.dart';

extension Section on _HomePageState {
  Widget TasktoWidget(Task task) {
    return Padding(padding: EdgeInsets.all(8.0),
      child: Dismissible(
        key: Key(task.id.toString()),
        onDismissed: (DismissDirection b) {
          service.deleteTaskfromDB(Task.destinationTable, task);
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

  createNewTaskForm() {
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
                    key: formKey,
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

//сохранение задачи
  void save() async {
    if (newTaskTxt != '') {
      Navigator.of(context).pop();
      Task item = Task(
          task: newTaskTxt,
          creationTime: DateTime.now().toString()
      );
      //добавление в БД
      service.addTasktoDB(Task.destinationTable, item);
      setState(() => newTaskTxt = '');
      refresh();
    }
  }

  Future<List<Task>> getTasks() async {
    List<Map<String, dynamic>> results = await service.getTablefromDB(
        Task.destinationTable);
    List<Task> todoList = results.map((item) => Task.fromMap(item)).toList();
    setState(() {

    });
    return todoList;
  }

    void refresh() async {
      List<Map<String, dynamic>> results = await DB.query(
          Task.destinationTable);
      todoList = results.map((item) => Task.fromMap(item)).toList();
      setState(() {

      });
    }

}
