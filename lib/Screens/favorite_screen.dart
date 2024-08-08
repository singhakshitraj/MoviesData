import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:flutter/material.dart';
import 'package:moviedb/API/list_operations.dart';
import 'package:moviedb/Models/tvSeries.dart' as tv_series;
import 'package:moviedb/Models/Movies.dart' as movies;
import 'package:moviedb/util/AggregateBlock.dart';
import 'package:moviedb/util/loading_animations.dart';
import 'package:moviedb/util/style.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late Future<List<movies.Results>> favMovies;
  late Future<List<tv_series.Results>> favSeries;

  @override
  void initState() {
    favMovies = ShowList().getMovieList('favorite');
    favSeries = ShowList().getTvSeriesList('favorite');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('MY FAVORITES'),
        ),
        body: SafeArea(
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
                        future: favMovies,
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
                                    width: MediaQuery.of(context).size.width,
                                    child: GridView.builder(
                                        itemCount: snapshot.data!.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 300),
                                        itemBuilder: (context, index) {
                                          return GridTile(
                                            footer: Padding(
                                              padding: paddingLeftRight,
                                              child: Container(
                                                color: Colors.purple,
                                                child: Text(
                                                  snapshot.data![index].title
                                                      .toString(),
                                                  style: style2.copyWith(
                                                      fontSize: 20),
                                                ),
                                              ),
                                            ),
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
                        future: favSeries,
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
                                    width: MediaQuery.of(context).size.width,
                                    child: GridView.builder(
                                        itemCount: snapshot.data!.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 300),
                                        itemBuilder: (context, index) {
                                          return GridTile(
                                            footer: Padding(
                                              padding: paddingLeftRight,
                                              child: Container(
                                                color: Colors.purple,
                                                child: Text(
                                                  snapshot
                                                      .data![index].originalName
                                                      .toString(),
                                                  style: style2.copyWith(
                                                      fontSize: 20),
                                                ),
                                              ),
                                            ),
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
        ));
  }
}
