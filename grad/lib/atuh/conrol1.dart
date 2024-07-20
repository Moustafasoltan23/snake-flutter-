import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // Import CupertinoIcons
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';

class conrol extends StatefulWidget {
  const conrol({Key? key}) : super(key: key);

  @override
  State<conrol> createState() => _conrolState();
}

class _conrolState extends State<conrol> {
  Timer? _timer;
  String temperature = "Loading...";

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer(DatabaseReference ref) {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      ref.set(100);
    });
  }

  void _stopTimer(DatabaseReference ref) {
    _timer?.cancel();
    _timer = null;
    ref.set(0);
  }

  @override
  Widget build(BuildContext context) {
    final DatabaseReference forwardRef = FirebaseDatabase.instance
        .reference()
        .child('ESP')
        .child('RobotControls')
        .child('forward');
    final DatabaseReference backwardRef = FirebaseDatabase.instance
        .reference()
        .child('ESP')
        .child('RobotControls')
        .child('backward');
    final DatabaseReference rightRef = FirebaseDatabase.instance
        .reference()
        .child('ESP')
        .child('RobotControls')
        .child('right');
    final DatabaseReference leftRef = FirebaseDatabase.instance
        .reference()
        .child('ESP')
        .child('RobotControls')
        .child('left');
    final DatabaseReference forwardRightRef = FirebaseDatabase.instance
        .reference()
        .child('ESP')
        .child('RobotControls')
        .child('forward_right');
    final DatabaseReference forwardLeftRef = FirebaseDatabase.instance
        .reference()
        .child('ESP')
        .child('RobotControls')
        .child('forward_left');
    final DatabaseReference backwardRightRef = FirebaseDatabase.instance
        .reference()
        .child('ESP')
        .child('RobotControls')
        .child('backward_right');
    final DatabaseReference backwardLeftRef = FirebaseDatabase.instance
        .reference()
        .child('ESP')
        .child('RobotControls')
        .child('backward_left');

    DatabaseReference temperatureRef = FirebaseDatabase.instance
        .reference()
        .child('ESP')
        .child('RobotControls')
        .child('temperature');

    temperatureRef.onValue.listen((event) {
      setState(() {
        temperature = event.snapshot.value.toString();
      });
    });

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 230,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
              gradient: LinearGradient(
                colors: [Colors.blue.shade800, Colors.blue.shade400],
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
                        "Control",
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildControlButton(
                        icon: CupertinoIcons.arrow_up_left,
                        onTapDown: () => _startTimer(forwardLeftRef),
                        onTapUp: () => _stopTimer(forwardLeftRef),
                        onTapCancel: () => _stopTimer(forwardLeftRef),
                      ),
                      SizedBox(width: 30), // Increased distance
                      buildControlButton(
                        icon: CupertinoIcons.arrow_up,
                        onTapDown: () => _startTimer(forwardRef),
                        onTapUp: () => _stopTimer(forwardRef),
                        onTapCancel: () => _stopTimer(forwardRef),
                      ),
                      SizedBox(width: 30), // Increased distance
                      buildControlButton(
                        icon: CupertinoIcons.arrow_up_right,
                        onTapDown: () => _startTimer(forwardRightRef),
                        onTapUp: () => _stopTimer(forwardRightRef),
                        onTapCancel: () => _stopTimer(forwardRightRef),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildControlButton(
                        icon: CupertinoIcons.arrow_left,
                        onTapDown: () => _startTimer(leftRef),
                        onTapUp: () => _stopTimer(leftRef),
                        onTapCancel: () => _stopTimer(leftRef),
                      ),
                      SizedBox(width: 90), // Increased distance
                      buildControlButton(
                        icon: CupertinoIcons.arrow_right,
                        onTapDown: () => _startTimer(rightRef),
                        onTapUp: () => _stopTimer(rightRef),
                        onTapCancel: () => _stopTimer(rightRef),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildControlButton(
                        icon: CupertinoIcons.arrow_down_left,
                        onTapDown: () => _startTimer(backwardLeftRef),
                        onTapUp: () => _stopTimer(backwardLeftRef),
                        onTapCancel: () => _stopTimer(backwardLeftRef),
                      ),
                      SizedBox(width: 30), // Increased distance
                      buildControlButton(
                        icon: CupertinoIcons.arrow_down,
                        onTapDown: () => _startTimer(backwardRef),
                        onTapUp: () => _stopTimer(backwardRef),
                        onTapCancel: () => _stopTimer(backwardRef),
                      ),
                      SizedBox(width: 30), // Increased distance
                      buildControlButton(
                        icon: CupertinoIcons.arrow_down_right,
                        onTapDown: () => _startTimer(backwardRightRef),
                        onTapUp: () => _stopTimer(backwardRightRef),
                        onTapCancel: () => _stopTimer(backwardRightRef),
                      ),
                    ],
                  ),
                  Card(
                    elevation: 4,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Text(
                            "Temperature:",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 5), // Add spacing between "Temperature:" and the value
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                temperature,
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
            ),
          ),
        ],
      ),
    );
  }

  Widget buildControlButton({
    required IconData icon,
    required VoidCallback onTapDown,
    required VoidCallback onTapUp,
    required VoidCallback onTapCancel,
  }) {
    return GestureDetector(
      onTapDown: (_) => onTapDown(),
      onTapUp: (_) => onTapUp(),
      onTapCancel: onTapCancel,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Colors.blue.shade800, Colors.blue.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          icon,
          size: 40,
          color: Colors.white,
        ),
      ),
    );
  }
}
