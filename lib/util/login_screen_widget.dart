import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviedb/util/style.dart';

Widget createWidget(String imagePath, String title, String description,
    Function() onPressed, double width) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(25),
    child: SizedBox(
      width: width * 0.8,
      child: ExpansionTile(
        leading: Container(
          margin: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(imagePath),
          ),
        ),
        childrenPadding: const EdgeInsets.all(10),
        backgroundColor: Colors.purple[300],
        collapsedBackgroundColor: Colors.purple[200],
        title: Text(
          title,
          style: GoogleFonts.kalnia(fontSize: 16, color: Colors.white),
        ),
        children: [
          Text(
            description,
            style: GoogleFonts.gupter(fontSize: 14, color: Colors.white),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                    onPressed: onPressed,
                    style: elevatedButtonStyle2(200, 40),
                    child: const Text('Login'))),
          ),
        ],
      ),
    ),
  );
}
