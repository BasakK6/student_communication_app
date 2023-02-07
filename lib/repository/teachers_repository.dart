import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TeachersRepository extends ChangeNotifier {
  final List<Teacher> teachers = [
    Teacher("Gerard", "Carney", 32, "male"),
    Teacher("Elena", "Shepard", 28, "female"),
  ];
}

final teachersProvider = ChangeNotifierProvider((ref) {
  return TeachersRepository();
});

class Teacher{
  String name;
  String surname;
  int age;
  String gender;

  Teacher(this.name, this.surname, this.age, this.gender);
}