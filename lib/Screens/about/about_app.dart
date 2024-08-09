import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviedb/util/style.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'This Project Is Developed Using Flutter And Dart by singhakshitraj. Some Important Third Party Dependencies Used In The App are - ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: paddingLeftRight,
                child: const Text(
                  '\n1. Carousel-Slider\n2. Gallery-Image\n3. Google Nav Bar\n4. Shared Preferences\n5. Shimmer\n6. URL Launcher\n7. Animated Segemnted Tabs\n8. HTTP\n9. Loading Animation Widget\n10. Percent Indicator\n11. Google Fonts',
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
