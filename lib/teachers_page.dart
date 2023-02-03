import 'package:flutter/material.dart';
import 'package:student_communication_app/repository/teachers_repository.dart';

class TeachersPage extends StatefulWidget {
  const TeachersPage({Key? key, required this.teachersRepository}) : super(key: key);

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
          const PhysicalModel(
            color: Colors.white,
            elevation: 10,
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Text("10 Teachers"),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => const ListTile(
                leading: Text("👩🏼"),//👦🏻
                title: Text("Sofia"),
              ),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: 25,
            ),
          ),
        ],
      ),
    );
  }
}