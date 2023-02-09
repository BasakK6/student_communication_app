import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_communication_app/pages/messages_page.dart';
import 'package:student_communication_app/repository/messages_repository.dart';
import 'package:student_communication_app/repository/students_repository.dart';
import 'package:student_communication_app/repository/teachers_repository.dart';
import 'package:student_communication_app/pages/students_page.dart';
import 'package:student_communication_app/pages/teachers_page.dart';

void main() {
  runApp(const ProviderScope(child: StudentApp()));
}

class StudentApp extends StatelessWidget {
  const StudentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Communication App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MainPage(title: 'Main Page'),
    );
  }
}

class MainPage extends ConsumerWidget {
  const MainPage({super.key, required this.title});

  final String title;

  void _goToStudentsPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>
          const StudentsPage(),
    ));
  }

  void _goToTeachersPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>
          const TeachersPage(),
    ));
  }

  Future<void> _goToMessagesPage(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>
         const MessagesPage(),
    ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentsRepository= ref.watch(studentsProvider);
    final newMessageCount = ref.watch(newMessageCountProvider);
    final teachersRepository= ref.watch(teachersProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text("Student's Name"),
            ),
            ListTile(
              title: const Text('Students'),
              onTap: () {
                Navigator.pop(context);
                _goToStudentsPage(context);
              },
            ),
            ListTile(
              title: const Text('Teachers'),
              onTap: () {
                Navigator.pop(context);
                _goToTeachersPage(context);
              },
            ),
            ListTile(
              title: const Text('Messages'),
              onTap: () {
                Navigator.pop(context);
                _goToMessagesPage(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                _goToMessagesPage(context);
              },
              child: Text("$newMessageCount New Massages"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                _goToStudentsPage(context);
              },
              child: Text("${studentsRepository.students.length} Students"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                _goToTeachersPage(context);
              },
              child: Text("${teachersRepository.teachers.length} Teachers"),
            ),
          ],
        ),
      ),
    );
  }
}
