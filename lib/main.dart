import 'package:flutter/material.dart';

import 'add_student.dart';
import 'edit_student.dart';
import 'home_page.dart';
import 'student_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(title: 'HomePage'),
        '/AddStudent': (context) => const AddStudent(),
        '/StudentList': (context) => StudentList(),
        '/EditStudent': (context) => const EditStudent(),
      },
    );
  }
}
