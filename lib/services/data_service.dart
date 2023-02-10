import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_communication_app/model/teacher.dart';
import 'package:http/http.dart' as http;

enum ApiPaths {
  teachers("teachers");

  const ApiPaths(this.path);

  final String path;

  String withSlash() {
    return "/$path";
  }
}

class DataService {
  final base_url = "https://63e522374474903105fa50b2.mockapi.io/api/v1";

  Future<Teacher> downloadTeacher() async {
    String id = "/8";
    final response = await http
        .get(Uri.parse("$base_url${ApiPaths.teachers.withSlash()}$id"));

    if (response.statusCode == 200) {
      final map = jsonDecode(response.body);
      final teacher = Teacher.fromMap(map);
      return teacher;
    } else {
      throw Exception("Failed to load teacher ${response.statusCode}");
    }
  }

  Future<void> addTeacher(Teacher teacher) async {
    String jsonString = jsonEncode(teacher.toMap());

    final response =await http.post(
      Uri.parse("$base_url${ApiPaths.teachers.withSlash()}"),
      headers: <String,String>{
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonString,
    );

    if(response.statusCode == 201){
      return;
    }
    else{
      throw Exception("Teacher could not be added ${response.statusCode}");
    }
  }

  int fakeExceptionCount = 0;
  Future<List<Teacher>> downloadAllTeachers() async{
    fakeExceptionCount++;

    if(fakeExceptionCount<3){
      throw Exception("Failed to load teachers - fake exception ($fakeExceptionCount times)");
    }

    final response = await http
        .get(Uri.parse("$base_url${ApiPaths.teachers.withSlash()}"));
    if (response.statusCode == 200) {
      final list = jsonDecode(response.body);
      if(list is List){
        return list.map<Teacher>((e)=>Teacher.fromMap(e)).toList();
      }
      else{
        throw Exception("Failed to load teachers, list conversion error ${response.statusCode}");
      }

    } else {
      throw Exception("Failed to load teachers ${response.statusCode}");
    }
  }
}

final dataServiceProvider = Provider((ref) {
  return DataService();
});
