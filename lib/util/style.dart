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
  padding: const EdgeInsets.only(left: 25, right: 25),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15),
  ),
  elevation: 0,
  alignment: Alignment.center,
  foregroundColor: Colors.white,
  backgroundColor: Colors.black,
);

ButtonStyle elevatedButtonStyle2(double width, double height) {
  return ElevatedButton.styleFrom(
    padding: const EdgeInsets.all(5),
    fixedSize: Size(width, height),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    elevation: 0,
    alignment: Alignment.center,
    foregroundColor: Colors.black,
    backgroundColor: Colors.white,
  );
}

TextStyle style2 = const TextStyle(
  color: Colors.white,
  fontSize: 12,
);

TextStyle style3 = const TextStyle(
  color: Colors.white,
  fontSize: 12,
);

InputDecoration textFieldDecoration = InputDecoration(
    fillColor: Colors.white,
    filled: true,
    hintText: 'Search Query Here',
    enabled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(32),
    ));
