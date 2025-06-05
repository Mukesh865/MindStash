import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../approutes.dart';



signUpUser(
    String userName,
    String userEmail,
    String userPassword,
)async{
User? userid = FirebaseAuth.instance.currentUser;
try{
  await FirebaseFirestore.instance.collection("users").doc(userid!.uid).set({
    'userName' : userName,
    'userEmail' : userEmail,
    'createdAt' : DateTime.now().toString(),
    'UserId' : userid.uid,
  }).then((value)=>{
    FirebaseAuth.instance.signOut(),
    Get.toNamed(AppRouts.login_screen),
  });
} on FirebaseException catch (e) {
  print("Error $e");
}
}