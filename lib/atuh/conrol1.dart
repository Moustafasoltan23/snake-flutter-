import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart'; // Import CupertinoIcons
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class conrol extends StatefulWidget {
  const conrol({Key? key}) : super(key: key);

  @override
  State<conrol> createState() => _conrolState();
}

class _conrolState extends State<conrol> {
  Timer? _timer;
  String temperature = "Loading...";
  late VlcPlayerController _videoPlayerController;
  bool isSwitch = false;

  @override
  void initState() {
    super.initState();

    // Initialize the controller with the correct parameters.
    _videoPlayerController = VlcPlayerController.network(
      'http://192.168.1.48:5000/video_feed',
      // Assuming 'HwAcc.FULL' is a valid constant; replace with a valid one if not.
      hwAcc: HwAcc.full,
      autoPlay: true,
      options: VlcPlayerOptions(),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer(DatabaseReference ref) {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      ref.set(100);
      if (ref == "mode") {
        ref.set(isSwitch);
      }
    });
  }

  void _stopTimer(DatabaseReference ref) {
    _timer?.cancel();
    _timer = null;
    ref.set(0);
    if (ref == "mode") {
      ref.set("mode");
    }
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
        .child('backward_righttt');
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
    DatabaseReference ModeRef = FirebaseDatabase.instance
        .reference()
        .child('ESP')
        .child('RobotControls')
        .child('Mode');

    temperatureRef.onValue.listen((event) {
      setState(() {
        temperature = event.snapshot.value.toString();
      });
    });
    String Mode;
    ModeRef.onValue.listen((event) {
      setState(() {
        Mode = event.snapshot.value.toString();
      });
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        shadowColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Text("Control & Stream"),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[200],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 230,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 56, 61, 67),
                  Colors.blue.shade400
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: VlcPlayer(
                    controller: _videoPlayerController,
                    aspectRatio: 16 / 9,
                    placeholder: Center(child: CircularProgressIndicator()),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                      const SizedBox(width: 30), // Increased distance
                      buildControlButton(
                        icon: CupertinoIcons.arrow_up,
                        onTapDown: () => _startTimer(forwardRef),
                        onTapUp: () => _stopTimer(forwardRef),
                        onTapCancel: () => _stopTimer(forwardRef),
                      ),
                      const SizedBox(width: 30), // Increased distance
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
                      const SizedBox(width: 90), // Increased distance
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
                      const SizedBox(width: 30), // Increased distance
                      buildControlButton(
                        icon: CupertinoIcons.arrow_down,
                        onTapDown: () => _startTimer(backwardRef),
                        onTapUp: () => _stopTimer(backwardRef),
                        onTapCancel: () => _stopTimer(backwardRef),
                      ),
                      const SizedBox(width: 30), // Increased distance
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
                          const Text(
                            "Temperature:",
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
                                temperature,
                                style: const TextStyle(
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
                  const Row(
                    children: [
                      Text(
                        "Mode",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Card(
                    color: Color.fromARGB(255, 37, 58, 76),
                    child: Switch(
                        value: isSwitch,
                        onChanged: (value) {
                          setState(() {
                            isSwitch = value;
                          });
                        }),
                  )
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
            colors: [const Color.fromARGB(255, 7, 7, 8), Colors.blue.shade400],
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
