import 'package:flutter/material.dart';

TextStyle style1 = const TextStyle(
  color: Colors.black,
  letterSpacing: 1.5,
  fontWeight: FontWeight.bold,
  decoration: TextDecoration.underline,
  fontSize: 15,
);

EdgeInsetsGeometry constMargin = const EdgeInsets.only(left: 24, right: 24);

ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
  padding: EdgeInsets.all(5),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15),
  ),
  elevation: 100,
  alignment: Alignment.center,
  foregroundColor: Colors.white,
  backgroundColor: Colors.black,
);

TextStyle style2 = TextStyle(
  color: Colors.white,
  fontSize: 12,
);
