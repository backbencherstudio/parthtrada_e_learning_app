import 'package:flutter/material.dart';

class DummyThree extends StatelessWidget {
  const DummyThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text("dummy 3",
        style: TextStyle(
          color: Color(0xff019877)
        ),
        ),
      ),
    );
  }
}