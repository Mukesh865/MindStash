import 'package:flutter/cupertino.dart';
import 'package:mindstash/screens/homescreen.dart';
import 'package:mindstash/screens/notesdetailsscreen.dart';
import 'package:mindstash/screens/splashscreen.dart';
import 'package:mindstash/screens/loginscreen.dart';
import 'package:mindstash/screens/signupscreen.dart';
import 'package:flutter/material.dart';
import 'package:mindstash/screens/forgotpass.dart';
import 'package:mindstash/screens/editorvirewscreen.dart';


class AppRouts{
  static const String splash_screen = '/splash';
  static const String login_screen = '/login';
  static const String signup_screen = '/signup';
  static const String forgot_pass_screen = '/forgotpass';
  static const String home_screen = '/home';
  static const String notes_screen = '/notesscreen';
  static const String editor_screen = '/editor';

  static Map<String, Widget Function(BuildContext)> getroutes() => {
    splash_screen: (context) => SplashScreen(),
    login_screen: (context) => LoginScreen(),
    signup_screen: (context) => SignupScreen(),
    forgot_pass_screen: (context) => ForgotPass(),
    home_screen: (context) => HomeScreen(),
    notes_screen: (context) => NotesDetailScreen(),
    editor_screen: (context) => EditorViewScreen(),
  };
}
