import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviedb/Screens/home_screen/firstDisplayScreen.dart';
import 'package:moviedb/Screens/auth/select_auth_method.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SelectAuthMethod(),
      theme: ThemeData(
        cardColor: Colors.white,
        textTheme:
            GoogleFonts.nanumGothicTextTheme(Theme.of(context).textTheme),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
          centerTitle: true,
          titleSpacing: 1.5,
        ),
        primaryColor: Colors.purple,
      ),
      routes: {
        '/toFirstDisplay/': (_) => const FirstDisplayScreen(),
      },
    );
  }
}
