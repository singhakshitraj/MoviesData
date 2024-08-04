import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:moviedb/API/auth.dart';
import 'package:moviedb/API/endpoints.dart';
import 'package:moviedb/Screens/next_auth.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool canLaunch = true;
  late String token;
  _displayToUser() async {
    FlutterNativeSplash.remove();
    token = await Auth().requestToken();
    print('Initial - $token');
    final Uri url = Uri.parse("${Endpoints.authRedirectUrl}$token");
    if (canLaunch) {
      canLaunch = false;
      Future.delayed(const Duration(seconds: 7));
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
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Please wait while it is being Loaded',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(
                child: ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return NextAuth(
                          token: token,
                        );
                      }));
                    },
                    child: const Text('Authenticated On Browser?')));
          }
        },
      ),
    );
  }
}
