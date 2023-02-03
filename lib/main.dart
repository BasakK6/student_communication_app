import 'package:flutter/material.dart';
import 'package:student_communication_app/messages_page.dart';
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

class MainPage extends StatelessWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
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
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const StudentsPage(),
                ));
              },
            ),
            ListTile(
              title: const Text('Teachers'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const TeachersPage(),
                ));
              },
            ),
            ListTile(
              title: const Text('Messages'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MessagesPage(),
                ));
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
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MessagesPage(),
                ));
              },
              child: const Text("10 New Massages"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const StudentsPage(),
                ));
              },
              child: const Text("10 Students"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const TeachersPage(),
                ));
              },
              child: const Text("10 Teachers"),
            ),
          ],
        ),
      ),
    );
  }
}
