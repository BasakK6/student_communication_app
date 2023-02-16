import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_communication_app/firebase_utilities/google_sign_in.dart';
import 'package:student_communication_app/pages/messages_page.dart';
import 'package:student_communication_app/repository/messages_repository.dart';
import 'package:student_communication_app/repository/students_repository.dart';
import 'package:student_communication_app/repository/teachers_repository.dart';
import 'package:student_communication_app/pages/students_page.dart';
import 'package:student_communication_app/pages/teachers_page.dart';
import 'package:student_communication_app/splash_screen.dart';

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
      home: const SplashScreen(), //const MainPage(title: 'Main Page'),
    );
  }
}

class MainPage extends ConsumerWidget {
  const MainPage({super.key, required this.title});

  final String title;

  void _goToStudentsPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const StudentsPage(),
    ));
  }

  void _goToTeachersPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const TeachersPage(),
    ));
  }

  Future<void> _goToMessagesPage(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const MessagesPage(),
    ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentsRepository = ref.watch(studentsProvider);
    final newMessageCount = ref.watch(newMessageCountProvider);
    final teachersRepository = ref.watch(teachersProvider);

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
            const UserDrawerHeader(),
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
            ListTile(
              title: const Text('Log out'),
              onTap: () async {
                await signOutWithGoogle();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => const SplashScreen(),
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

class UserDrawerHeader extends StatefulWidget {
  const UserDrawerHeader({
    super.key,
  });

  @override
  State<UserDrawerHeader> createState() => _UserDrawerHeaderState();
}

class _UserDrawerHeaderState extends State<UserDrawerHeader> {
  late Future<Uint8List?> _profilePic;
  late final String? uid;

  String get userPicPath => "$uid.jpg";

  @override
  void initState() {
    super.initState();
    uid = FirebaseAuth.instance.currentUser?.uid;
    _profilePic = _downloadProfilerPicture();
  }

  Future<Uint8List?> _downloadProfilerPicture() async {
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    Map<String, dynamic>? data = documentSnapshot.data();

    if (data?.keys.contains("profilePicturePath") ?? false) {
      String pathRef = data!["profilePicturePath"];
      Uint8List? uInt8List =
          await FirebaseStorage.instance.ref(pathRef).getData();
      return uInt8List; //return picture data
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: const BoxDecoration(
        color: Colors.blue,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              FirebaseAuth.instance.currentUser?.displayName ?? "No User Name"),
          const SizedBox(
            height: 8,
          ),
          Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              FutureBuilder<Uint8List?>(
                  future: _profilePic,
                  builder: (context, snapshot) {
                    return snapshot.hasData && snapshot.data != null
                        ? CircleAvatar(
                            radius: 40,
                            backgroundImage: MemoryImage(snapshot.data!),
                          )
                        : const CircleAvatar(
                            radius: 40,
                            child: Text("BK"),
                          );
                  }),
              Positioned(
                top: -10,
                right: -15,
                child: IconButton(
                  onPressed: () async {
                    XFile? xFile = await ImagePicker()
                        .pickImage(source: ImageSource.camera);
                    if (xFile == null) return;
                    final imagePath = xFile.path;
                    final Reference profilePicturePath = FirebaseStorage
                        .instance
                        .ref("profile_pictures")
                        .child(userPicPath);
                    await profilePicturePath.putFile(File(imagePath));
                    await FirebaseFirestore.instance
                        .collection("users")
                        .doc(uid)
                        .update({
                      "profilePicturePath": profilePicturePath.fullPath,
                    });
                    //data is put in the storage, now we must refresh the circle avatar
                    setState(() {
                      _profilePic = _downloadProfilerPicture();
                    });
                  },
                  icon: const Icon(Icons.camera_alt),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
