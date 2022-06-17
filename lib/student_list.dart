import 'dart:math';

import 'package:flutter/material.dart';
import 'package:student_list/add_student.dart';
import 'edit_student.dart';
import 'student_class.dart';

class StudentList extends StatefulWidget {
  final List<Student> _students = Student.generateStudentData(20);

  StudentList({Key? key}) : super(key: key);

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Student List',
        ),
      ),
      body: ListView.builder(
        itemCount: widget._students.length,
        itemExtent: 90,
        itemBuilder: _listItemBuilder,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: Text(
                'HR App',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            ListTile(
              title: const Text('Add Employee'),
              onTap: () {
                Navigator.popAndPushNamed(context, "/AddEmployee");
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, size: 50),
        onPressed: () => onFloatingActionButtonPressed(context),
      ),
    );
  }

  Widget _listItemBuilder(BuildContext context, int index) {
    Student student = widget._students[index];
    return Dismissible(
      child: _getStudentCard(
        student,
        context,
      ),
      key: UniqueKey(),
      background: Container(color: Colors.blue[100]),
      onDismissed: (direction) {
        setState(() {
          if (direction == DismissDirection.startToEnd) {
            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Please Confirm'),
                content: Column(
                  children: [
                    Text('ID:\t${student.id}'),
                    Text('Name:\t${student.name}'),
                    Text('GPA:\t${student.gpa.toInt()}'),
                    const Text('Image:'),
                    Image(
                      image: AssetImage(student.imageUrl),
                      fit: BoxFit.scaleDown,
                    ),
                    const Text('Are you sure you want to delete?'),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'Close');
                      },
                      child: const Text('Close')),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'Yes');
                        setState(() {
                          widget._students.remove(student);
                        });
                      },
                      child: const Text('Yes')),
                ],
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                
                content: Text('${student.name}  dismissed!'),
              ),
            );
           } //else if (direction == DismissDirection.endToStart) {
          //   if (index > 0) {
          //     widget._students.remove(student);
          //     widget._students.insert(index - 1, student);
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       SnackBar(
          //         content: Text('direction = $direction'),
          //       ),
          //     );
          //   }
          // }
        });
      },
    );
  }

  Widget _getStudentCard(Student student, BuildContext context) {
    double newScale = 0;
    return GestureDetector(
      // onScaleStart: (details) {
      //   print('pointerCount: ${details.pointerCount}');
      //   print('focalPoint: ${details.focalPoint}');
      // },
      // onScaleUpdate: (details) {
      //   newScale = details.scale;
      // },
      // onScaleEnd: (details) {
      //   print('newScale is: $newScale');
      //   if (newScale > 1) {
      //     //Add new Student
      //     _addNewStudents(student);
      //   }
      //   if (newScale < 1) {
      //     //Add new Student
      //     // print('newScale is: $newScale');
      //     _removeStudents(student);
      //   }
      // },
      onLongPress: () => _onStudentLongPress(student, context),
      child: Container(
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        alignment: Alignment.centerLeft,
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Theme.of(context).colorScheme.secondary),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Image(
                image: AssetImage(student.imageUrl),
                fit: BoxFit.scaleDown,
              ),
              Column(
                children: [
                  Text(
                    student.name,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(
                    'GPA: ${student.gpa.toInt()}',
                    style: Theme.of(context).textTheme.headline6,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void _addNewStudents(Student student) {
  //   int newId = widget._students.length + 1;
  //   double newGpa = Random().nextDouble() * 100;
  //   String newName = 'Student $newId';
  //   String newImage = newGpa % 2 == 0 ? 'images/s2.ico' : 'images/s1.ico';
  //   Student newStudent =
  //       Student(id: newId, gpa: newGpa, imageUrl: newImage, name: newName);
  //   int index =
  //       widget._students.indexWhere((element) => element.id == newStudent.id);
  //   index = index == -1 ? 0 : index;
  //   setState(() {
  //     widget._students.insert(index, newStudent);
  //   });
  // }

  // void _removeStudents(Student student) {
  //   int newId = widget._students.length + 1;
  //   double newGpa = Random().nextDouble() * 100;
  //   String newName = 'Student $newId';
  //   String newImage = newGpa % 2 == 0 ? 'images/s2.ico' : 'images/s1.ico';
  //   Student newStudent =
  //       Student(id: newId, gpa: newGpa, imageUrl: newImage, name: newName);
  //   int index =
  //       widget._students.indexWhere((element) => element.id == newStudent.id);
  //   index = index == -1 ? 0 : index;
  //   setState(() {
  //     widget._students.removeAt(index);
  //   });
  // }

  Future<void> _onStudentLongPress(
      Student student, BuildContext context) async {
    final Student? result = await Navigator.pushNamed(
        context, EditStudent.routeName,
        arguments: student) as Student?;
    if (result == null) {
      return;
    }
    int i = widget._students.indexOf(student);
    setState(() {
    widget._students[i] = result;
     });
    // widget._students.add(Student.getNew());
    // for (int i = 0; i < widget._students.length; i++) {
    //   if (widget._students[i].id == result.id) {
    //     setState(() {
    //       widget._students[i] = result;
    //     });
    //   }
    // }
  }

  Future<void> onFloatingActionButtonPressed(BuildContext context) async {
    final Student? result =
        await Navigator.pushNamed(context, AddStudent.routeName) as Student?;

    if (result == null) {
      return;
    }
    result.id = widget._students.length;
    result.imageUrl = "images/s2.ico";
    setState(() {
      widget._students.add(result);
    });
    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(
    //     content: Text(
    //       'You presed on the Floating Action Button',
    //     ),
    //   ),
    // );
  }
}
