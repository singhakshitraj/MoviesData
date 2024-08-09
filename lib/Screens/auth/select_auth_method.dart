import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviedb/Screens/auth/auth_screen.dart';
import 'package:moviedb/util/login_screen_widget.dart';

class SelectAuthMethod extends StatelessWidget {
  const SelectAuthMethod({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return Scaffold(
        body: Stack(
      children: [
        Container(
          color: Colors.purple[50],
        ),
        SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Icon(
                  Icons.person,
                  color: Colors.purple[400],
                  size: 300,
                ),
                Center(
                  child: Text(
                    'WELCOME BACK!!',
                    style: GoogleFonts.gupter(fontSize: 30, wordSpacing: 1.2),
                  ),
                ),
                Center(
                  child: Text(
                    'Please Choose A Method From The Following Options',
                    style: GoogleFonts.gupter(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  child: createWidget(
                      'lib/Assets/the-movie-db-logo.jpeg',
                      'Login With TMDB Account',
                      'Using This Method Involves Login with TMDB Account. If you don\'t have an account yet, you can create one in the upcoming steps. Logging In With this method enables you to bookmark and favourite your movies and TV Series. If you don\'t feel like creating an account, you can do a Guest Login from the Item below.',
                      () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                                'You will now be redirected to TMDB website. If you wish to make a guest login, select Cancel and make a Guest Login'),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('CANCEL')),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const AuthScreen()));
                                  },
                                  child: const Text('REDIRECT')),
                            ],
                          );
                        });
                  }, MediaQuery.of(context).size.width),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
