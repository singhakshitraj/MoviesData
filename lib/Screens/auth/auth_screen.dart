import 'package:flutter/material.dart';
import 'package:moviedb/API/auth.dart';
import 'package:moviedb/API/endpoints.dart';
import 'package:moviedb/API/shared_preferences.dart';
import 'package:moviedb/util/loading_animations.dart';
import 'package:moviedb/util/style.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool canLaunch = true;
  late String token;

  Future<String> _matchIDs(String token) async {
    final isSuccess = await Auth().createSession(token);
    return isSuccess;
  }

  _displayToUser() async {
    token = await Auth().requestToken();
    final Uri url = Uri.parse("${Endpoints.authRedirectUrl}$token");
    if (canLaunch) {
      canLaunch = false;
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _displayToUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Align(
              alignment: Alignment.center,
              child: AlertDialog(
                backgroundColor: Colors.black,
                content: Container(
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Please wait while you\'ll be redirected',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      fourRotatingDots,
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: elevatedButtonStyle2(250, 40).copyWith(
                        foregroundColor:
                            const WidgetStatePropertyAll(Colors.white),
                        backgroundColor:
                            const WidgetStatePropertyAll(Colors.black)),
                    onPressed: () async {
                      final urlToLaunch =
                          Uri.parse("${Endpoints.authRedirectUrl}$token");
                      await launchUrl(urlToLaunch);
                    },
                    child: const Text('Redirect Again !!')),
                const SizedBox(height: 30),
                ElevatedButton(
                    style: elevatedButtonStyle2(250, 40).copyWith(
                        foregroundColor:
                            const WidgetStatePropertyAll(Colors.white),
                        backgroundColor:
                            const WidgetStatePropertyAll(Colors.black)),
                    onPressed: () async {
                      final vals = await _matchIDs(token);
                      if (vals == '-1') {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text(
                                    'Error! Make Sure You Have Authenticated On The Provided Link.'),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('OKAY')),
                                ],
                              );
                            });
                      } else {
                        saveAccountID(vals);
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/toFirstDisplay/', (_) => false);
                      }
                    },
                    child: const Text('Authenticated On Browser?'))
              ],
            ));
          }
        },
      ),
    );
  }
}
