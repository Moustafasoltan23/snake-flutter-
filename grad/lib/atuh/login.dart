import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grad/components/logo.dart';
import 'package:grad/components/matrialbutton.dart';
import 'package:grad/components/textformfiled.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController passward = TextEditingController();

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);

    Navigator.of(context)
        .pushNamedAndRemoveUntil("homepage1", (route) => false);
  }

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
                  "Login",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 5,
                ),
                const Text(
                  "Login to continue to using the app",
                  style: TextStyle(color: Colors.grey),
                ),
                Container(
                  height: 20,
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
                      return "can't be empty";
                    }
                  },
                ),
                Container(
                  height: 10,
                ),
                const Text(
                  "Passward",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 10,
                ),
                customtextform(
                  hinttext: "Enter Your Password",
                  mycontroller: passward,
                  validator: (val) {
                    if (val == "") {
                      return "can't use that";
                    }
                  },
                ),
                InkWell(
                  onTap: () async {
                    if (email.text == "") {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'error Title',
                        desc: 'الرجاء التاكد من كتابه البريد الالكتروني',
                      ).show();
                      return;
                    }
                    try {
                      await FirebaseAuth.instance
                          .sendPasswordResetEmail(email: email.text);
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.success,
                        animType: AnimType.rightSlide,
                        title: 'error Title',
                        desc:
                            'لقد تم ارسال لينك لاعاده تعيين كلمه المرور الي بريدك الالكتروني',
                      ).show();
                    } catch (e) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'error Title',
                        desc: 'Please enter the true Email',
                      ).show();
                    }
                  },
                  child: Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 20),
                      alignment: Alignment.topRight,
                      child: const Text(
                        "Forget Password ?",
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      )),
                ),
              ],
            ),
          ),
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            height: 45,
            color: Colors.black,
            onPressed: () async {
              if (formState.currentState!.validate()) {
                try {
                  final credential =
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email.text,
                    password: passward.text,
                  );
                  Navigator.of(context).pushReplacementNamed("homepage");
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    print('No user found for that email.');
                    // ignore: use_build_context_synchronously
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.rightSlide,
                      title: 'error Title',
                      desc: 'No user found for that email.',
                    ).show();
                  } else if (e.code == 'wrong-password') {
                    print('Wrong password provided for that user.');
                    // ignore: use_build_context_synchronously
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.rightSlide,
                      title: 'error Title',
                      desc: 'Wrong password provided for that user.',
                    ).show();
                  }
                }
              } else {
                print("Not vailed");
              }
            },
            child: const Text(
              "Login",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Container(
            height: 10,
          ),
          const Text(
            "Or Login with ",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.blue),
          ),
          Container(
            height: 10,
          ),
          matrialbutton(
            title: "Login with goggle",
            onPressed: () async {
              signInWithGoogle();
            },
          ),
          Container(
            height: 10,
          ),
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            height: 45,
            color: Colors.black,
            onPressed: () {},
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Login with Phone number",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          Container(
            height: 20,
          ),

          // Text("Don't have An Account ? Register" , textAlign: TextAlign.center,)
          InkWell(
              onTap: () {
                Navigator.of(context).pushReplacementNamed("signup");
              },
              child: const Center(
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                      text: "Don't have An Account ?",
                      style: TextStyle(fontSize: 14)),
                  TextSpan(
                      text: " Register",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                ])),
              )),
        ]),
      ),
    );
  }
}
