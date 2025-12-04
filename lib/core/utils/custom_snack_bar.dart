import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context, String message, {Color? bgColor}) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).padding.top + 40.0,
      left: 20.0,
      right: 20.0,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: bgColor ?? Colors.black,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 4.0),
            ],
          ),
          child: Text(
            message,
            style: TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ),
  );

  // Insert the overlay entry
  overlay.insert(overlayEntry);

  // Remove the custom SnackBar after 2 seconds
  Future.delayed(Duration(seconds: 2), () {
    overlayEntry.remove();
  });
}
