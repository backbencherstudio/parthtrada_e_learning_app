import 'package:flutter/material.dart';

class DummyOne extends StatelessWidget {
  const DummyOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text("dummy 1",
        style: TextStyle(
          color: Color(0xff019877)
        ),
        ),
      ),
    );
  }
}