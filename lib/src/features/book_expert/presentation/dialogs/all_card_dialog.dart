import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllCardDialog {
  showAllCardDialog(context) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        content: Column(
          children: [
            Text('All Cards'),
            SizedBox(height: 16.h),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 16.h),
                  child: Text('Card $index'),
                );
              },
            ),
          ],
        ),
      );
    });
  }
}