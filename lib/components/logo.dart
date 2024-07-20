import 'package:flutter/material.dart';

class customelogo extends StatelessWidget {
  const customelogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 250,
        height: 200,
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(70),
        ),
        child: Image.asset(
          "image/1234.jpeg",
          width: 230,
          height: 195,
        ),
      ),
    );
  }
}
