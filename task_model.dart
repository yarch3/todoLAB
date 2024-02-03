class Task{
   int? id;
   String task;
   String creationTime;

   static String destinationTable = 'TodoList';

   Task({this.id, required this.task, required this.creationTime});

   Map<String, dynamic> toMap() {
      Map<String, dynamic> map = { 'task': task, 'dateTime': creationTime};
      return map;
   }

   static Task fromMap(Map<String, dynamic> map) {
      return Task(
         id: map['id'],
         task: map['task'],
          creationTime: map['dateTime']
      );
   }



}