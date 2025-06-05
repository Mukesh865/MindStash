import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mindstash/approutes.dart';

class NotesDetailScreen extends StatefulWidget{
  const NotesDetailScreen({super.key});

  @override
  State<NotesDetailScreen> createState() => _NotesDetailScreenState();
}

class _NotesDetailScreenState extends State<NotesDetailScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  User? userId = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff3ede8),
        appBar: AppBar(
          backgroundColor: const Color(0xfff3ede8),
          elevation: 0,
        leading: IconButton(onPressed: (){
          Navigator.pushReplacementNamed(context, AppRouts.home_screen);
        },
            icon: Icon(Icons.arrow_back_ios_new_rounded,color: Colors.black,)),
        title: const Text('Notes',style: TextStyle(fontSize: 18,color: Colors.black),),
        actions: [
          IconButton(onPressed: () async{
            var noteTitle = titleController.text.trim();
            var note = noteController.text.trim();
            if (note != ""){
              try{
                   await FirebaseFirestore.instance.collection("notes").doc().set({
                     "CreatedAt": DateTime.now(),
                     "Title": noteTitle,
                     "Note": note,
                     "UserId": userId!.uid,
                   });
              }catch(e){
                print("Error $e");
              }
              Navigator.pushReplacementNamed(context, AppRouts.home_screen);

            }
          },
              icon: Icon(Icons.done ,color: Colors.black,)),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: titleController,
                  style: TextStyle(fontSize: 30,color: Colors.black),
                  decoration: InputDecoration(
                    hintText: "Title",
                    hintStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none,
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                ),
              ),
              const SizedBox(height: 10,),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: noteController,
                  style: TextStyle(fontSize: 17,color: Colors.black),
                  decoration: InputDecoration(
                    hintText: "Note",
                    hintStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none,
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}