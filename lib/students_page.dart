import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_communication_app/repository/students_repository.dart';

class StudentsPage extends ConsumerWidget {
  const StudentsPage({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final studentsRepository = ref.watch(studentsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Students"),
      ),
      body: Column(
        children: [
          PhysicalModel(
            color: Colors.white,
            elevation: 10,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                    "${studentsRepository.students.length} Students"),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => StudentListTile(
                student: studentsRepository.students[index],
              ),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: studentsRepository.students.length,
            ),
          ),
        ],
      ),
    );
  }
}

class StudentListTile extends ConsumerWidget {
  const StudentListTile({
    required this.student,
    super.key,
  });

  final Student student;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool doILikeThem = ref.watch(studentsProvider).doILikeThem(student);

    return ListTile(
      leading: IntrinsicWidth(
          child: Center(
              child: Text(student.gender == "female" ? "👩🏼" : "👦🏻"))),
      title: Text("${student.name} ${student.surname}"),
      subtitle: Text(student.age.toString()),
      trailing: IconButton(
        onPressed: () {

          ref.read(studentsProvider).changeLikeStatus(student, doILikeThem);

        },
        icon: Icon(
            doILikeThem ?  Icons.favorite
            : Icons.favorite_border ),
      ),
    );
  }
}
