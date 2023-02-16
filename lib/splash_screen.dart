import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:student_communication_app/firebase_utilities/google_sign_in.dart';

import 'main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isFirebaseInitialized = false;

  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    setState(() {
      isFirebaseInitialized = true;
    });
    if (FirebaseAuth.instance.currentUser != null) { //If the user is already signed in
      print(FirebaseAuth.instance.currentUser?.uid);
      goToTheMainPage();
    }
  }

  void goToTheMainPage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (context) => const MainPage(title: 'Main Page')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isFirebaseInitialized
            ? ElevatedButton(
                onPressed: () async {
                   await signInWithGoogle();
                   goToTheMainPage();
                }, child: const Text("Google Sign In"))
            : CircularProgressIndicator(),
      ),
    );
  }
}
