import 'package:flutter/material.dart';
import 'package:moviedb/API/auth.dart';

class NextAuth extends StatefulWidget {
  String token;
  NextAuth({required this.token, super.key});

  @override
  State<NextAuth> createState() => _NextAuthState();
}

class _NextAuthState extends State<NextAuth> {
  Future<String> _matchIDs(String token) async {
    final isSuccess = await Auth().createSession(token);
    return isSuccess;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _matchIDs(widget.token),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
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
            if (snapshot.data == null || snapshot.data == '-1') {
              return const Text('Unsuccessful');
            } else {
              return const Text('Successful');
            }
          }
        });
  }
}
