import 'package:flutter/material.dart';
import 'package:todolist/pages/homepage.dart';
import 'db/db_file.dart';

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

