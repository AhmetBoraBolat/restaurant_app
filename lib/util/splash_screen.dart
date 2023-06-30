import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../login/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isFirebaseInitialized = false;

  @override
  void initState() {
    super.initState();

    initializeFireBase();
  }

  Future<void> initializeFireBase() async {
    await Firebase.initializeApp();
    setState(() {
      isFirebaseInitialized = true;
    });
    navigateToLoginPage();
  }

  void navigateToLoginPage() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
