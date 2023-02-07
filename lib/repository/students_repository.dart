import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudentsRepository extends ChangeNotifier{
  final List<Student> students = [
    Student("Rachel", "Greene", 18, "female"),
    Student("Kiara", "Valenzuela", 16, "female"),
    Student("Howard", "Terry", 15, "male"),
    Student("Jonah", "Walker", 18, "male"),
    Student("Erin", "Erin", 17, "female"),
    Student("Ada", "Stanton", 18, "female"),
    Student("Jane", "Stein", 18, "female"),
  ];

  final Set<Student> likedStudents = {};

  bool doILikeThem(Student student) {
    return likedStudents.contains(student);
  }

  void changeLikeStatus(Student student, bool doILike) {
    if(doILike){
      likedStudents.remove(student);
    }
    else{
      likedStudents.add(student);
    }
    notifyListeners();
  }
}

final studentsProvider = ChangeNotifierProvider(
    (ref){
      return StudentsRepository();
    }
);

class Student{
  String name;
  String surname;
  int age;
  String gender;

  Student(this.name, this.surname, this.age, this.gender);
}