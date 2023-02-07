import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_communication_app/repository/teachers_repository.dart';

class TeachersPage extends ConsumerWidget {
  const TeachersPage({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teachersRepository = ref.watch(teachersProvider);

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
                    "${teachersRepository.teachers.length} Teachers"),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => TeacherListTile(
                teacher: teachersRepository.teachers[index],
              ),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: teachersRepository.teachers.length,
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
