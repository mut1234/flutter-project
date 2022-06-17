import 'package:flutter/material.dart';

import 'student_class.dart';

class AddStudent extends StatefulWidget {
  static const String title = 'Add New Student';
  static const String routeName = '/AddStudent';

  const AddStudent({Key? key}) : super(key: key);
  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Student _student = Student.getNew();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AddStudent.title)),
      body: SingleChildScrollView(
          child: Center(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
                    TextFormField(
                        initialValue: _student.name,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(),
                          labelText: 'Name',
                          helperText: '* Required',
                          prefixIcon: Icon(Icons.account_circle),
                        ),
                        validator: (newValue) {
                          if (newValue!.isEmpty || newValue.trim().length < 3) {
                            return 'Name is required, and should be 3 characters at least!';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _student.name = newValue!;
                        },
                      ),
                          const Text('Change gender will auto change picture'),
                      DropdownButton<Gender>(
                        value: _student.gender,
                        onChanged: (newValue) => setState(() {
                          _student.gender = newValue!;
                          _student.imageUrl = _student.gender == Gender.Male? 'images/s1.ico' : 'images/s2.ico';
                        }),
                        items: const [
                          DropdownMenuItem(
                              child: Text('Male'), value: Gender.Male),
                          DropdownMenuItem(
                              child: Text('Female'), value: Gender.Female),
                        ],
                      ),
                      //  const EnumDropdownButton(),
                      // TextFormField(
                      //   initialValue: student.gender.name,
                      //   decoration: const InputDecoration(
                      //     enabledBorder: OutlineInputBorder(),
                      //     labelText: 'Gender',
                      //     helperText: '* Required',
                      //     prefixIcon: Icon(Icons.account_circle),
                      //   ),
                      //   validator: (newValue) {
                      //     if (newValue!.isEmpty || newValue.trim().length < 3) {
                      //       return 'Name is required, and should be 3 characters at least!';
                      //     }
                      //     return null;
                      //   },
                      //   onSaved: (newValue) {
                      //     student.gender =Gender.values.firstWhere((element) => false);
                      //   },
                      // ),
                      TextFormField(
                        initialValue: _student.gpa.toInt().toString(),
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(),
                          labelText: 'Gpa',
                          helperText: '* Required',
                          prefixIcon: Icon(Icons.account_circle),
                        ),
                        validator: (newValue) {
                          if (newValue == null || newValue.isEmpty) {
                            return "GPA is required";
                          }
                          double val = double.tryParse(newValue)!;
                          if (val < 0 || val > 100) {
                            return "GPA is required";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          double val = double.tryParse(newValue!)!;
                          _student.gpa = val;
                        },
                      ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('New Student added!')));
                    _formKey.currentState!.save();
                    Navigator.pop(context, _student);
                  }
                },
                child: const Text('save'),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
