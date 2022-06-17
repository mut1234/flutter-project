
import 'package:flutter/material.dart';
import 'package:student_list/student_class.dart';

class EditStudent extends StatefulWidget {
  static const String title = 'Edit Student';
  static const String routeName = '/EditStudent';

  const EditStudent({Key? key}) : super(key: key);

  @override
  State<EditStudent> createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  @override
  Widget build(BuildContext context) {
    final Student student =
        ModalRoute.of(context)!.settings.arguments as Student;
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(EditStudent.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(children: [
                      TextFormField(
                        initialValue: student.name,
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
                          student.name = newValue!;
                        },
                      ),
                     const Text('Change gender will auto change picture'),

                      DropdownButton<Gender>(
                        value: student.gender,
                        onChanged: (newValue) => setState(() {
                          student.gender = newValue!;
                          student.imageUrl = student.gender == Gender.Male? 'images/s1.ico' : 'images/s2.ico';
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
                        initialValue: student.gpa.toInt().toString(),
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
                          student.gpa = val;
                        },
                      ),
                    ]),
                  ),
                  ElevatedButton(
                    child: const Text(
                      'Save',
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                       _formKey.currentState!.save();
                        Navigator.pop(context, student);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


// enum Gender { Male, Female }

// class EnumDropdownButton extends StatefulWidget {
//   const EnumDropdownButton( {Key? key}) : super(key: key);

//   @override
//   State<EnumDropdownButton> createState() => _EnumDropdownButtonState();
// }
// class _EnumDropdownButtonState extends State<EnumDropdownButton> {
//   Gender _value = Gender.Male;
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<Gender>(
//       value: _value,
//       onChanged: (newValue) => setState(() {
//         _value = newValue!;
//       }),
//       items: const [
//         DropdownMenuItem(
//             child: Text('Male'), value: Gender.Male),
//         DropdownMenuItem(
//             child: Text('Female'), value: Gender.Female),
//       ],
      
//     );
//   }
// }