import 'package:flutter/material.dart';
import 'package:moviedb/util/style.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController queryText = TextEditingController();
  String green = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.purple[500],
        foregroundColor: Colors.white,
        title: TextField(
          onChanged: (str) {
            setState(() {
              green = str;
            });
          },
          autofocus: true,
          controller: queryText,
          decoration: textFieldDecoration,
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.ac_unit_sharp))
        ],
      ),
      body: Center(
          child: Text(
        green,
        style: TextStyle(fontSize: 50),
      )),
    );
  }
}
