import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'package:mindstash/approutes.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPass extends StatefulWidget{
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  TextEditingController forgotPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff3ede8),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Color(0xfff3ede8),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Forgot Password', style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
              ],
            ),
            SizedBox(height: 10,),
            Text('Enter your email to reset your password'),
            SizedBox(height: 10,),
            Container(
              alignment: Alignment.center,
              height: 300,
              child: Lottie.asset("assets/emailanimation.json"),
            ),
            SizedBox(height: 20,),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: forgotPassController,
                  decoration: InputDecoration(hintText: 'Email', enabledBorder: OutlineInputBorder(),prefixIcon: Icon(Icons.email)),
                )
            ),
            SizedBox(height: 40,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: ElevatedButton(
                  onPressed: () async{
                    var forgotemail = forgotPassController.text.trim();
                    try{
                       FirebaseAuth.instance.sendPasswordResetEmail(email: forgotemail);
                      Get.snackbar("Success", "Password reset email sent");
                      Navigator.pushReplacementNamed(context , AppRouts.login_screen);
                    }on FirebaseAuthException catch(e){
                      print("Error $e");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Light green color
                    foregroundColor: Colors.black, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                    ),
                    minimumSize: Size(double.infinity, 50), // Full width, fixed height
                    elevation: 0, // No shadow
                  ),
                  child: Text('Continue')),
            ),
            SizedBox(height: 10,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushReplacementNamed(context , AppRouts.login_screen);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                    ),
                    minimumSize: Size(double.infinity, 50), // Full width, fixed height
                    elevation: 0, // No shadow
                  ),
                  child: Text('Cancel')),
            ),
          ],
        ),
      ),
    );
  }
}