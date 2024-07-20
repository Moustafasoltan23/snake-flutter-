import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grad/components/matrialbutton.dart';
import 'package:grad/components/textformfiled.dart';

class addcategory extends StatefulWidget {
  const addcategory({super.key});

  @override
  State<addcategory> createState() => _addcategoryState();
}

class _addcategoryState extends State<addcategory> {
  GlobalKey<FormState> fromstate = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  CollectionReference control1 =
      FirebaseFirestore.instance.collection('control1');

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return control1
        .add({"name": name.text})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add categroy")),
      body: Form(
        key: fromstate,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              child: customtextform(
                  hinttext: "enter name",
                  mycontroller: name,
                  validator: (val) {
                    if (val == "") {
                      return "can't to empty";
                    }
                    return null;
                  }),
            ),
            matrialbutton(
              title: "add",
              onPressed: () {
                addUser();
              },
            )
          ],
        ),
      ),
    );
  }
}
