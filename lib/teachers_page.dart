import 'package:flutter/material.dart';
import 'package:student_communication_app/repository/teachers_repository.dart';

class TeachersPage extends StatefulWidget {
  const TeachersPage({Key? key, required this.teachersRepository})
      : super(key: key);

  final TeachersRepository teachersRepository;

  @override
  State<TeachersPage> createState() => _TeachersPageState();
}

class _TeachersPageState extends State<TeachersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Teachers")),
      body: Column(
        children: [
          PhysicalModel(
            color: Colors.white,
            elevation: 10,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                    "${widget.teachersRepository.teachers.length} Teachers"),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => TeacherListTile(
                teacher: widget.teachersRepository.teachers[index],
              ),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: widget.teachersRepository.teachers.length,
            ),
          ),
        ],
      ),
    );
  }
}

class TeacherListTile extends StatelessWidget {
  const TeacherListTile({
    super.key,
    required this.teacher,
  });

  final Teacher teacher;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IntrinsicWidth(
        child: Center(
          child: Text(teacher.gender == "female" ? "👩🏼" : "👦🏻"),
        ),
      ),
      title: Text("${teacher.name} ${teacher.surname}"),
      subtitle: Text(teacher.age.toString()),
    );
  }
}
