import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class voice_chat extends StatefulWidget {
  const voice_chat({super.key});

  @override
  State<voice_chat> createState() => _voice_chatState();
}

class _voice_chatState extends State<voice_chat> {
  String voicechat = "loaading..";

  @override
  Widget build(BuildContext context) {
    final DatabaseReference voice_ref = FirebaseDatabase.instance
        .reference()
        .child('ESP')
        .child('RobotControls')
        .child("voicchat");
    voice_ref.onValue.listen((event) {
      setState(() {
        voicechat = event.snapshot.value.toString();
      });
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        shadowColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Text("Voice Chat"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Column(
            children: [
              Container(
                height: 230,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromARGB(255, 28, 41, 55),
                      Colors.blue.shade400
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 80,
                      left: 0,
                      child: Container(
                        height: 100,
                        width: 300,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              offset: Offset(-10, 0),
                              blurRadius: 20,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "Voice Chat",
                            style: TextStyle(
                              fontSize: 40,
                              color: const Color.fromARGB(255, 48, 95, 134),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Card(
                elevation: 4,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      const Text(
                        "Voice Chat:",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                          width:
                              5), // Add spacing between "Temperature:" and the value
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "voicechat",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
