import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class profile_page extends StatefulWidget {
  const profile_page({super.key});

  @override
  State<profile_page> createState() => _profile_pageState();
}

class _profile_pageState extends State<profile_page> {
  double coverheight = 280; //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                GoogleSignIn googleSignIn = GoogleSignIn();
                googleSignIn.disconnect();
                await FirebaseAuth.instance.signOut();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("login", (route) => false);
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          bulidtop(),
          buildContent(),
        ],
      ),
    );
  }
}

double coverheight = 280; // Replace 200.0 with the desired height value

Widget bulidcoveryimage() => Container(
      color: Colors.grey,
      child: Image.asset(
        "image/code.jpeg",
        width: double.infinity,
        height: coverheight,
        fit: BoxFit.cover,
      ),
    );
double profileheight = 144;
final bootom = profileheight / 2;

Widget bulidprofileborder() => CircleAvatar(
      radius: profileheight / 2,
      backgroundColor: Colors.grey.shade800,
      backgroundImage: AssetImage("image/me.jpg"),
    );

Widget bulidtop() {
  final top = coverheight - profileheight / 2;
  return Stack(
    clipBehavior: Clip.none,
    alignment: Alignment.center,
    children: [
      Container(
        margin: EdgeInsets.only(bottom: bootom),
        child: bulidcoveryimage(),
      ),
      Positioned(top: top, child: bulidprofileborder())
    ],
  );
}

Widget buildContent() => Column(
      children: [
        SizedBox(
          height: 8,
        ),
        Text(
          "Moustafa Soltan",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Flutter Software Engineer",
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.heart_fill,
              color: Colors.red,
              size: 24.0,
            ),
            SizedBox(
              width: 12,
            ),
            Icon(
              CupertinoIcons.gift,
              color: Colors.red,
              size: 24.0,
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "About Me",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "Cross-platform: Flutter allows developers to build applications that run seamlessly on both Android and iOS platforms, using a single codebase, Flutter uses a widget-based architecture for building user interfaces. Everything in Flutter is a widget, allowing for a highly customizable and flexible UI design,  One of the most beloved features of Flutter is its hot reload capability, which enables,developers to instantly see the changes they make to the code reflected in the app, speeding up the development process, Dart  Flutter apps are written in the Dart programming language, which is also developed by Google,Dart is known for its simplicity, speed, and reliability, Flutter provides widgets that implement the Material Design guidelines for Android apps and the Cupertino widgets for iOS apps, ensuring a native look and feel on both platforms",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
              )
            ],
          ),
        )
      ],
    );
