import 'package:flutter/material.dart';
import 'package:student_communication_app/messages_page.dart';
import 'package:student_communication_app/repository/messages_repository.dart';
import 'package:student_communication_app/repository/students_repository.dart';
import 'package:student_communication_app/repository/teachers_repository.dart';
import 'package:student_communication_app/students_page.dart';
import 'package:student_communication_app/teachers_page.dart';

void main() {
  runApp(const StudentApp());
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

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final MessagesRepository messagesRepository;
  late final StudentsRepository studentsRepository;
  late final TeachersRepository teachersRepository;

  @override
  void initState() {
    super.initState();

    messagesRepository = MessagesRepository();
    studentsRepository = StudentsRepository();
    teachersRepository = TeachersRepository();
  }

  void _goToStudentsPage() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>
          StudentsPage(studentsRepository: studentsRepository),
    ));
  }

  void _goToTeachersPage() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>
          TeachersPage(teachersRepository: teachersRepository),
    ));
  }

  Future<void> _goToMessagesPage() async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>
          MessagesPage(messagesRepository: messagesRepository),
    ));

    // The change in the new message count is reflected without a state management method
    // Messages page changes the newMessageCount  to 0 in its initState
    // In order to notify the main page UI we await the return and then, run setState
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
                _goToStudentsPage();
              },
            ),
            ListTile(
              title: const Text('Teachers'),
              onTap: () {
                Navigator.pop(context);
                _goToTeachersPage();
              },
            ),
            ListTile(
              title: const Text('Messages'),
              onTap: () {
                Navigator.pop(context);
                _goToMessagesPage();
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
                _goToMessagesPage();
              },
              child: Text("${messagesRepository.newMessageCount} New Massages"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                _goToStudentsPage();
              },
              child: Text("${studentsRepository.students.length} Students"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                _goToTeachersPage();
              },
              child: Text("${teachersRepository.teachers.length} Teachers"),
            ),
          ],
        ),
      ),
    );
  }
}
