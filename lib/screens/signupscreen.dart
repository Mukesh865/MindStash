import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mindstash/approutes.dart';
import 'package:get/get.dart';
import 'dart:developer';
import 'package:mindstash/userServices/signUpService.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController userNameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isuserPasswordVisible = false;
  bool isconfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3ede8),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: const Color(0xfff3ede8),
        centerTitle: true,
        title: const Text('Signup'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  height: 120,
                  width: 120,
                  child: Image.asset('assets/mindstashlogo.png'),
                ),
              ),
              const Text(
                'Welcome to MindStash',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 5),
              const Text('Stash Your Thoughts, Anytime. Anywhere.'),
              const SizedBox(height: 20),
              const Text(
                'Create an account',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              const SizedBox(height: 30),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: userNameController,
                  decoration: const InputDecoration(
                    hintText: 'Your name',
                    enabledBorder: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person_2_outlined),
                  ),
                  validator: (value) =>
                  value == null || value.isEmpty ? 'Enter your name' : null,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: userEmailController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                    enabledBorder: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Enter your email';
                    if (!value.contains('@') || !value.contains('.'))
                      return 'Enter a valid email';
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: userPasswordController,
                  obscureText: !isuserPasswordVisible,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    enabledBorder: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.password_outlined),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isuserPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          isuserPasswordVisible = !isuserPasswordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Enter your password';
                    if (value.length < 6)
                      return 'Password must be at least 6 characters';
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: confirmPasswordController,
                  obscureText: !isconfirmPasswordVisible,
                  decoration: InputDecoration(
                    hintText: 'Confirm your password',
                    enabledBorder: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.password_outlined),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isconfirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          isconfirmPasswordVisible = !isconfirmPasswordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Confirm your password';
                    if (value != userPasswordController.text)
                      return 'Passwords do not match';
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    var userName = userNameController.text.trim();
                    var userEmail = userEmailController.text.trim();
                    var userPassword = userPasswordController.text.trim();

                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: userEmail,
                        password: userPassword,
                      );

                      signUpUser(userName, userEmail, userPassword);
                      Get.snackbar("Success", "User created successfully");
                    } catch (error) {
                      log("Error: $error");
                      Get.snackbar("Signup Failed", error.toString());
                    }
                  } else {
                    Get.snackbar("Error", "Please correct the errors in form");
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, AppRouts.login_screen);
                },
                child: const Card(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text('Already have an account? Login'),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
