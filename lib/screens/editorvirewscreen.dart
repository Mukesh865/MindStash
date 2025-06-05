import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindstash/approutes.dart';

class EditorViewScreen extends StatefulWidget {
  const EditorViewScreen({super.key});

  @override
  State<EditorViewScreen> createState() => _EditorViewScreenState();
}

class _EditorViewScreenState extends State<EditorViewScreen> {
  late TextEditingController titleController;
  late TextEditingController noteController;
  late String docId;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments ?? {};

    // Use default values in case any field is missing
    titleController = TextEditingController(text: args['title'] ?? '');
    noteController = TextEditingController(text: args['content'] ?? '');
    docId = args['docId'] ?? '';
    _isInitialized = true;
  }

  @override
  void dispose() {
    titleController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      backgroundColor: const Color(0xfff3ede8),
      appBar: AppBar(
        backgroundColor: const Color(0xfff3ede8),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, AppRouts.home_screen);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
        ),
        title: const Text(
          'Notes',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              var noteTitle = titleController.text.trim();
              var note = noteController.text.trim();
              if (note.isNotEmpty && docId.isNotEmpty) {
                try {
                  await FirebaseFirestore.instance.collection("notes").doc(docId).update({
                    'Title': noteTitle,
                    'Note': note,
                  });
                  log("Data Updated Successfully");
                } catch (e) {
                  log("Error: $e");
                }
                Navigator.pushReplacementNamed(context, AppRouts.home_screen);
              }
            },
            icon: const Icon(Icons.done, color: Colors.black),
          ),
          IconButton(onPressed: (){
            FirebaseFirestore.instance.collection("notes").doc(docId).delete();
            Navigator.pushReplacementNamed(context, AppRouts.home_screen);
            log("Data Deleted Successfully");
          }, icon: const Icon(Icons.delete,color: Colors.black,))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: titleController,
                  style: const TextStyle(fontSize: 30, color: Colors.black),
                  decoration: const InputDecoration(
                    hintText: "Title",
                    hintStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none,
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: noteController,
                  style: const TextStyle(fontSize: 17, color: Colors.black),
                  decoration: const InputDecoration(
                    hintText: "Note",
                    hintStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none,
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
