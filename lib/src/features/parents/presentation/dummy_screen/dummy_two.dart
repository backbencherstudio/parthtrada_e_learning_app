import 'package:flutter/material.dart';

class DummyTwo extends StatelessWidget {
  const DummyTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text("dummy 2",
        style: TextStyle(
          color: Color(0xff019877)
        ),
        ),
      ),
    );
  }
}