import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:grad/atuh/conrol1.dart';
import 'package:grad/atuh/gps.dart';
import 'package:grad/atuh/profile.dart';
import 'package:grad/atuh/voice.dart';
import 'package:grad/atuh/welcome.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<homepage> {
  int selectindex = 0;
  List<Widget> listwidget = [
    welcome_screen(),
    conrol(),
    voice_chat(),
    MyApp(),
    profile_page(),
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
      bottomNavigationBar: ConvexAppBar(
        color: Color.fromARGB(255, 255, 255, 255),
        backgroundColor: Color.fromARGB(159, 44, 81, 159),
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.settings_input_antenna, title: 'Control'),
          TabItem(icon: Icons.voice_chat, title: 'Voice'),
          TabItem(icon: Icons.gps_fixed, title: 'gps'),
          TabItem(icon: Icons.people, title: 'Profile page'),
        ],
        onTap: (int index) {
          setState(() {
            selectindex = index;
          });
        },
      ),
      body: listwidget.elementAt(selectindex),
    );
  }

  void _changeindex(int value) {
    setState(() {
      selectindex = value;
    });
  }
}
