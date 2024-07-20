import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // The 'Key?' type makes the key optional and provides a default value if 'null' is passed.
  MyHomePage({Key? key}) : super(key: key ?? GlobalKey());

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Marking the controller as 'late' because it is initialized in 'initState'.
  late VlcPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();

    // Initialize the controller with the correct parameters.
    _videoPlayerController = VlcPlayerController.network(
      '192.168.1.48:5000/video_feed',
      // Assuming 'HwAcc.FULL' is a valid constant; replace with a valid one if not.
      hwAcc: HwAcc.full,
      autoPlay: true,
      options: VlcPlayerOptions(),
    );
  }

  @override
  void dispose() {
    // Corrected the dispose method to be synchronous and use 'dispose' on the correct controller.
    _videoPlayerController.stopRendererScanning();
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: VlcPlayer(
          controller: _videoPlayerController,
          aspectRatio: 16 / 9,
          placeholder: Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
