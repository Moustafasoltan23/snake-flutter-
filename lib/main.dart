import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grad/atuh/conrol1.dart';
import 'package:grad/atuh/login.dart';
import 'package:grad/atuh/profile.dart';
import 'package:grad/atuh/signup.dart';
import 'package:grad/atuh/welcome.dart';
import 'package:grad/catgories/add.dart';
import 'package:grad/homepage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('=====================User is currently signed out!');
      } else {
        print('=====================User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.black,
              titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w700),
              iconTheme: IconThemeData(color: Colors.white))),
      debugShowCheckedModeBanner: false,
      home: (FirebaseAuth.instance.currentUser != null &&
              FirebaseAuth.instance.currentUser!.emailVerified)
          ? homepage()
          : Login(),
      routes: {
        "welcome": (context) => welcome_screen(),
        "signup": (context) => signup(),
        "login": (context) => Login(),
        "homepage": (context) => homepage(),
        "add": (context) => addcategory(),
        "control1": (context) => conrol(),
        "mainscreen": (context) => homepage(),
        "MyApp": (context) => MyApp(),
        "profile": (context) => profile_page(),
      },
    );
  }
}
