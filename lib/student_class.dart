import 'dart:math';

enum Gender { Male, Female }

class Student {
  int id;
  String name;
  double gpa;
  String imageUrl;
  Gender gender;

  Student(
      {this.id = -1,
      this.name = '',
      this.gpa = 35,
      this.imageUrl = '',
      this.gender = Gender.Male});

  static Student getNew() {
    return Student(
        id: -1, name: '', gpa: 99, gender: Gender.Male, imageUrl: '');
  }

  static List<Student> generateStudentData(int count) {
    List<Student> students = [];
    for (int i = 1; i <= count; i++) {
      double gpaRandom = Random().nextDouble() * (100);
      students.add(
        Student(
            id: i,
            name: 'Student $i',
            gpa: gpaRandom,
            imageUrl: gpaRandom % 2 == 0 ? 'images/s2.ico' : 'images/s1.ico',
            gender: gpaRandom % 2 == 0 ? Gender.Female : Gender.Male),
      );
    }
    return students;
  }
}
