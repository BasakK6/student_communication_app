import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_communication_app/repository/teachers_repository.dart';
import 'package:student_communication_app/services/data_service.dart';

import '../model/teacher.dart';

class TeacherFormPage extends ConsumerStatefulWidget {
  const TeacherFormPage({Key? key}) : super(key: key);

  @override
  ConsumerState<TeacherFormPage> createState() => _TeacherFormState();
}

class _TeacherFormState extends ConsumerState<TeacherFormPage> {
  final Map<String, dynamic> entered = {};
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Teacher Info"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text("Name"),
                  ),
                  validator: (value) {
                    if (value?.isNotEmpty != true) {
                      return "Name can not be empty";
                    }
                  },
                  onSaved: (newValue) {
                    entered["name"] = newValue;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text("Surname"),
                  ),
                  validator: (value) {
                    if (value?.isNotEmpty != true) {
                      return "Surname can not be empty";
                    }
                  },
                  onSaved: (newValue) {
                    entered["surname"] = newValue;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text("Age"),
                  ),
                  validator: (value) {
                    if (value == null || value.isNotEmpty != true) {
                      return "Age can not be empty";
                    }
                    if (int.tryParse(value) == null) {
                      return "Only numbers can be entered in this field";
                    }
                  },
                  keyboardType: TextInputType.number,
                  onSaved: (newValue) {
                    entered["age"] = int.tryParse(newValue!);
                  },
                ),
                DropdownButtonFormField(
                  items: const [
                    DropdownMenuItem(
                      value: "Male",
                      child: Text("Male"),
                    ),
                    DropdownMenuItem(
                      value: "Female",
                      child: Text("Female"),
                    ),
                  ],
                  value: entered["gender"],
                  onChanged: (value) {
                    setState(() {
                      entered["gender"] = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return "Please choose a gender";
                    }
                  },
                ),
                isSaving
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: () {
                          final formState = _formKey.currentState;
                          if (formState == null) return;
                          if (formState.validate() == true) {
                            formState.save();
                            saveTeacher();
                          }
                        },
                        child: const Text("Save"),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isSaving = false;

  void negateIsSaving() {
    setState(() {
      isSaving = !isSaving;
    });
  }

  Future<void> saveTeacher() async {
    try {
      negateIsSaving();
      final Teacher teacher = Teacher.fromMap(entered);
      await ref.read(dataServiceProvider).addTeacher(teacher);

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Teacher was created")));

      Navigator.of(context).pop(true);

    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("The teacher could not be loaded")));
    } finally {
      negateIsSaving();
    }
  }
}
