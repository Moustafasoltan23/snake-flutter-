import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grad/atuh/conrol1.dart';
import 'package:grad/atuh/gps.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<homepage> {
  int selectindex = 0;
  List<Widget> listwidget = [
    Container(
      color: const Color.fromARGB(255, 213, 190, 181),
    ),
    conrol(),
    Text(
      "page3",
      style: TextStyle(fontSize: 20, color: Colors.black),
    ),
    Gps()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.of(context).pushNamed("add");
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Home page"),
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
      bottomNavigationBar: BottomNavigationBar(
          onTap: _changeindex,
          currentIndex: selectindex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.orange,
          backgroundColor: Colors.green,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.control_point), label: "Control"),
            BottomNavigationBarItem(
                icon: Icon(Icons.voice_chat), label: "Voice Chat"),
            BottomNavigationBarItem(icon: Icon(Icons.gps_fixed), label: "Gps"),
          ]),
      body: listwidget.elementAt(selectindex),
    );
  }

  void _changeindex(int value) {
    setState(() {
      selectindex = value;
    });
  }
}
