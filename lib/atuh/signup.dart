import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad/components/logo.dart';
import 'package:grad/components/matrialbutton.dart';
import 'package:grad/components/textformfiled.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController passward = TextEditingController();

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(children: [
          Form(
            key: formState,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                ),
                const customelogo(),
                Container(
                  height: 10,
                ),
                const Text(
                  "Sign up",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 5,
                ),
                const Text(
                  "Sign up to continue to using the app",
                  style: TextStyle(color: Colors.grey),
                ),
                Container(
                  height: 20,
                ),
                const Text(
                  "User name",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 10,
                ),
                customtextform(
                  hinttext: "Enter Your user name",
                  mycontroller: username,
                  validator: (val) {
                    if (val == "") {
                      return "can't use that";
                    }
                  },
                ),
                Container(
                  height: 10,
                ),
                Container(
                  height: 10,
                ),
                const Text(
                  "Email",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 10,
                ),
                customtextform(
                  hinttext: "Enter Your Email",
                  mycontroller: email,
                  validator: (val) {
                    if (val == "") {
                      return "can't used thet";
                    }
                  },
                ),
                Container(
                  height: 10,
                ),
                const Text("Passward",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                Container(
                  height: 10,
                ),
                customtextform(
                  hinttext: "Enter Your Password",
                  mycontroller: passward,
                  validator: (val) {
                    if (val == "") {
                      return "can't used thet";
                    }
                  },
                ),
                Container(
                  height: 10,
                ),
              ],
            ),
          ),
          Container(
            height: 20,
          ),
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            height: 45,
            color: Colors.black,
            onPressed: () {},
            child: const Text(
              "Login",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Container(
            height: 20,
          ),
          matrialbutton(
            title: "Sign up",
            onPressed: () async {
              if (formState.currentState!.validate()) {
                try {
                  final credential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: email.text,
                    password: passward.text,
                  );
                  FirebaseAuth.instance.currentUser!.sendEmailVerification();
                  Navigator.of(context).pushReplacementNamed("Login");
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print('The password provided is too weak.');
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.info,
                      animType: AnimType.rightSlide,
                      title: 'Dialog Title',
                      desc: 'Dialog description here.............',
                    )..show();
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                  }
                } catch (e) {
                  print(e);
                }
              }
            },
          ),

          Container(
            height: 30,
          ),

          InkWell(
              onTap: () {
                Navigator.of(context).pushNamed("homepage");
              },
              child: const Center(
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                      text: " have An Account ?",
                      style: TextStyle(fontSize: 14)),
                  TextSpan(
                      text: " Login",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                ])),
              )),
          // Text("Don't have An Account ? Register" , textAlign: TextAlign.center,)
        ]),
      ),
    );
  }
}
