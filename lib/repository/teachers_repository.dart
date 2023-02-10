import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_communication_app/model/teacher.dart';
import 'package:student_communication_app/services/data_service.dart';

class TeachersRepository extends ChangeNotifier {
  List<Teacher> teachers = [
    Teacher("Gerard", "Carney", 32, "male"),
    Teacher("Elena", "Shepard", 28, "female"),
  ];

  DataService dataService;
  TeachersRepository(this.dataService);

  Future<void> download() async {
    Teacher teacher = await dataService.downloadTeacher();
    teachers.add(teacher);
    notifyListeners();
  }

  Future<List<Teacher>> downloadAllTeachers() async{
    teachers = await dataService.downloadAllTeachers();
    return teachers;
  }

}

final teachersProvider = ChangeNotifierProvider((ref) {
  return TeachersRepository(ref.watch(dataServiceProvider));
});

final teachersListProvider = FutureProvider((ref){
    return ref.watch(teachersProvider).downloadAllTeachers();
});