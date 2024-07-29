import 'package:flutter/material.dart';
import 'package:moviedb/API/serverCalls.dart';
import 'package:moviedb/util/AggregateBlock.dart';
import 'package:moviedb/util/loading_animations.dart';
import 'package:moviedb/util/style.dart';

import 'package:moviedb/Models/Movies.dart' as movies;

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController queryText = TextEditingController();
  late Future<List<movies.Results>> querySearchResults;
  bool canBuild = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.purple[500],
        foregroundColor: Colors.white,
        title: TextField(
          autofocus: true,
          controller: queryText,
          decoration: textFieldDecoration,
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  querySearchResults =
                      ServerCalls().getSearchResults(queryText.text);
                  canBuild = true;
                });
              },
              icon: const Icon(Icons.ac_unit_sharp))
        ],
      ),
      body: (!canBuild)
          ? const Center(
              child: Text('Your Queries Will Be Answered Here'),
            )
          : FutureBuilder(
              future: querySearchResults,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: fourRotatingDots,
                  );
                } else {
                  return (snapshot.data!.isEmpty)
                      ? const Center(
                          child: Text('No Results Found'),
                        )
                      : GridView.builder(
                          itemCount: snapshot.data!.length,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 300),
                          itemBuilder: (context, index) {
                            return GridTile(
                              footer: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  snapshot.data![index].title.toString(),
                                  style: style2.copyWith(fontSize: 20),
                                ),
                              ),
                              child: Container(
                                height: 500,
                                child: AggregateBlock(
                                  snapshot: snapshot,
                                  index: index,
                                  tv: (snapshot.data![index].mediaType == 'tv')
                                      ? -1
                                      : 0,
                                ),
                              ),
                            );
                          });
                }
              },
            ),
    );
  }
}
