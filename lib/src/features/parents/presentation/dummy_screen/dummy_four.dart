import 'package:flutter/material.dart';

class DummyFour extends StatelessWidget {
  const DummyFour({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text("dummy 4",
        style: TextStyle(
          color: Color(0xff019877)
        ),
        ),
      ),
    );
  }
}