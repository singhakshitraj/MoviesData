import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:flutter/material.dart';
import 'package:moviedb/API/search.dart';
import 'package:moviedb/API/serverCalls.dart';
import 'package:moviedb/util/AggregateBlock.dart';
import 'package:moviedb/util/loading_animations.dart';
import 'package:moviedb/util/style.dart';
import 'package:moviedb/Models/tvSeries.dart' as tv_series;
import 'package:moviedb/Models/Movies.dart' as movies;

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController queryText = TextEditingController();
  late Future<List<movies.Results>> queryMovieSearchResults;
  late Future<List<tv_series.Results>> queryTvSearchResults;
  bool canBuild = false;
  final _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.purple[500],
        foregroundColor: Colors.white,
        title: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_focusNode),
          child: TextField(
            autofocus: true,
            controller: queryText,
            decoration: textFieldDecoration,
            focusNode: _focusNode,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                queryText.clear();
                setState(() {
                  canBuild = false;
                  FocusScope.of(context).requestFocus(_focusNode);
                });
              },
              icon: const Icon(Icons.clear)),
          IconButton(
              onPressed: () {
                setState(() {
                  queryMovieSearchResults =
                      SearchResults().getMovieSearchResults(queryText.text);
                  queryTvSearchResults =
                      SearchResults().getTvSeriesSearchResults(queryText.text);
                  canBuild = true;
                  _focusNode.unfocus();
                });
              },
              icon: const Icon(Icons.search_rounded)),
        ],
      ),
      body: (!canBuild)
          ? const Center(
              child: Text('Your Queries Will Be Answered Here'),
            )
          : SafeArea(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: SegmentedTabControl(
                        indicatorDecoration: const BoxDecoration(
                          color: Colors.purple,
                        ),
                        squeezeIntensity: 2,
                        textStyle: style1,
                        tabs: [
                          SegmentTab(
                            label: 'MOVIES',
                            backgroundColor: Colors.purple[200],
                          ),
                          SegmentTab(
                            label: 'TV',
                            backgroundColor: Colors.purple[200],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(children: [
                        FutureBuilder(
                            future: queryMovieSearchResults,
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
                                    : Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: GridView.builder(
                                            itemCount: snapshot.data!.length,
                                            gridDelegate:
                                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                                    maxCrossAxisExtent: 300),
                                            itemBuilder: (context, index) {
                                              return GridTile(
                                                /*footer: Padding(
                                                  padding: paddingLeftRight,
                                                  child: Container(
                                                    color: Colors.purple,
                                                    child: Text(
                                                      snapshot
                                                          .data![index].title
                                                          .toString(),
                                                      style: style2.copyWith(
                                                          fontSize: 20),
                                                    ),
                                                  ),
                                                ),*/
                                                child: Container(
                                                  height: 500,
                                                  child: AggregateBlock(
                                                    snapshot: snapshot,
                                                    index: index,
                                                    tv: 0,
                                                  ),
                                                ),
                                              );
                                            }),
                                      );
                              }
                            }),
                        FutureBuilder(
                            future: queryTvSearchResults,
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
                                    : Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: GridView.builder(
                                            itemCount: snapshot.data!.length,
                                            gridDelegate:
                                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                                    maxCrossAxisExtent: 300),
                                            itemBuilder: (context, index) {
                                              return GridTile(
                                                /*footer: Padding(
                                                  padding: paddingLeftRight,
                                                  child: Container(
                                                    color: Colors.purple,
                                                    child: Text(
                                                      snapshot.data![index]
                                                          .originalName
                                                          .toString(),
                                                      style: style2.copyWith(
                                                          fontSize: 20),
                                                    ),
                                                  ),
                                                ),*/
                                                child: Container(
                                                  height: 500,
                                                  child: AggregateBlock(
                                                    snapshot: snapshot,
                                                    index: index,
                                                    tv: -1,
                                                  ),
                                                ),
                                              );
                                            }),
                                      );
                              }
                            }),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
