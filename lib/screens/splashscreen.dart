import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mindstash/approutes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateUser();
  }

  void _navigateUser() async {
    await Future.delayed(const Duration(seconds: 3)); // splash duration

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.pushReplacementNamed(context, AppRouts.home_screen); // Replace with your home screen route
    } else {
      Navigator.pushReplacementNamed(context, AppRouts.login_screen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3ede8),
      body: Center(
        child: SizedBox(
          height: 200,
          width: 200,
          child: Image.asset('assets/mindstashlogo.png'),
        ),
      ),
    );
  }
}
