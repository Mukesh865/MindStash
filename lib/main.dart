import 'package:get/get.dart';
import 'package:mindstash/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mindstash/screens/loginscreen.dart';
import 'package:mindstash/screens/splashscreen.dart';
import 'package:mindstash/approutes.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

 class MyApp extends StatefulWidget{
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User ? user;
  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mind Stash',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      routes: AppRouts.getroutes() ,
      initialRoute: AppRouts.splash_screen,
    );
  }
}


