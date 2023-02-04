import 'package:flutter/material.dart';
import 'package:student_communication_app/repository/students_repository.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({Key? key, required this.studentsRepository})
      : super(key: key);

  final StudentsRepository studentsRepository;

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  @override
  Widget build(BuildContext context) {
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
                    "${widget.studentsRepository.students.length} Students"),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => StudentListTile(
                student: widget.studentsRepository.students[index],
                studentsRepository: widget.studentsRepository,
              ),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: widget.studentsRepository.students.length,
            ),
          ),
        ],
      ),
    );
  }
}

class StudentListTile extends StatefulWidget {
  const StudentListTile({
    required this.student,
    required this.studentsRepository,
    super.key,
  });

  final Student student;
  final StudentsRepository studentsRepository;

  @override
  State<StudentListTile> createState() => _StudentListTileState();
}

class _StudentListTileState extends State<StudentListTile> {

  @override
  Widget build(BuildContext context) {

    bool doILikeThem = widget.studentsRepository.doILikeThem(widget.student);

    return ListTile(
      leading: IntrinsicWidth(
          child: Center(
              child: Text(widget.student.gender == "female" ? "👩🏼" : "👦🏻"))),
      title: Text("${widget.student.name} ${widget.student.surname}"),
      subtitle: Text(widget.student.age.toString()),
      trailing: IconButton(
        onPressed: () {
          setState(() {
            widget.studentsRepository.changeLikeStatus(widget.student, doILikeThem);
          });
        },
        icon: Icon(
            doILikeThem ?  Icons.favorite
            : Icons.favorite_border ),
      ),
    );
  }
}
