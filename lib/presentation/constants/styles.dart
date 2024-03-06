import 'package:flutter/material.dart';

class Styles {
   static ButtonStyle customButtonStyle = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
    ), backgroundColor: Colors.black87,
    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
  );
}
