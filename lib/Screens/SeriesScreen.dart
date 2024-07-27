import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:moviedb/API/endpoints.dart';
import 'package:moviedb/API/serverCalls.dart';
import 'package:moviedb/Models/Movies.dart' as Movies;
import 'package:moviedb/Models/People.dart' as People;
import 'package:moviedb/Models/tvSeries.dart' as tvSeries;
import 'package:moviedb/util/AggregateBlock.dart';
import 'package:moviedb/util/style.dart';
import 'package:shimmer/shimmer.dart';

class SeriesScreen extends StatefulWidget {
  const SeriesScreen({super.key});

  @override
  State<SeriesScreen> createState() => _SeriesScreenState();
}

class _SeriesScreenState extends State<SeriesScreen> {
  late Future<List<Movies.Results>> trendingAll;
  late Future<List<Movies.Results>> trendingMovie;
  late Future<List<Movies.Results>> trendingTv;
  late Future<List<People.Results>> trendingPeople;
  late Future<List<tvSeries.Results>> airingToday;
  late Future<List<tvSeries.Results>> onTheAir;
  late Future<List<tvSeries.Results>> tvPopular;
  late Future<List<tvSeries.Results>> tvTopRated;
  Endpoints ep = Endpoints();
  _wait() async {
    FlutterNativeSplash.remove();
  }

  @override
  void initState() {
    trendingAll = ServerCalls().getMoviesData('all');
    trendingMovie = ServerCalls().getMoviesData('movie');
    trendingTv = ServerCalls().getMoviesData('tv');
    trendingPeople = ServerCalls().getPeopleData('person');
    airingToday = ServerCalls().getSeriesData('airing_today');
    onTheAir = ServerCalls().getSeriesData('on_the_air');
    tvPopular = ServerCalls().getSeriesData('popular');
    tvTopRated = ServerCalls().getSeriesData('top_rated');
    _wait();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 11,
          title: const Text(
            'Movies',
          ),
        ),
        drawer: const Drawer(),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              Text(
                'Trending',
                style: style1,
                textAlign: TextAlign.center,
              ),
              Container(
                height: 420,
                child: FutureBuilder(
                    future: trendingAll,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return CarouselSlider.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index, ind) {
                              return AggregateBlock(
                                snapshot: snapshot,
                                index: index,
                              );
                            },
                            options: CarouselOptions(
                              disableCenter: true,
                              animateToClosest: true,
                            ));
                      }
                    }),
              ),
              Text('Trending In Movies', style: style1),
              const SizedBox(
                height: 8,
              ),
              Container(
                height: 230,
                child: FutureBuilder(
                    future: trendingMovie,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return AggregateBlock(
                                  snapshot: snapshot, index: index);
                            },
                            separatorBuilder: (context, index) => const Divider(
                                  height: 5,
                                ),
                            itemCount: snapshot.data!.length);
                      } else {
                        return Shimmer.fromColors(
                            baseColor: Colors.purple,
                            highlightColor: Colors.deepPurpleAccent,
                            child: const Text('Shimmer'));
                      }
                    }),
              ),
              const SizedBox(
                height: 8,
              ),
              Text('Trending In TV', style: style1),
              const SizedBox(
                height: 8,
              ),
              Container(
                height: 230,
                child: FutureBuilder(
                    future: trendingTv,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return AggregateBlock(
                                  snapshot: snapshot, index: index);
                            },
                            separatorBuilder: (context, index) => const Divider(
                                  height: 5,
                                ),
                            itemCount: snapshot.data!.length);
                      } else {
                        return Shimmer.fromColors(
                            baseColor: Colors.black,
                            highlightColor: Colors.white,
                            child: const Text('Shimmer'));
                      }
                    }),
              ),
              const SizedBox(
                height: 8,
              ),
              Text('Trending In People', style: style1),
              const SizedBox(
                height: 8,
              ),
              Container(
                height: 130,
                child: FutureBuilder(
                    future: trendingPeople,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.all(7),
                                child: CircleAvatar(
                                  radius: 40,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(40),
                                    child: Container(
                                      width: 80,
                                      height: 80,
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: ep.completeImageUrl(snapshot
                                            .data![index].profilePath
                                            .toString()),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => const Divider(
                                  height: 5,
                                ),
                            itemCount: snapshot.data!.length);
                      } else {
                        return Shimmer.fromColors(
                            baseColor: Colors.black,
                            highlightColor: Colors.white,
                            child: const Text('Shimmer'));
                      }
                    }),
              ),
              const SizedBox(
                height: 8,
              ),
              Text('Top Series Today', style: style1),
              const SizedBox(
                height: 8,
              ),
              /*----------------------*/
              Container(
                height: 230,
                child: FutureBuilder(
                    future: airingToday,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return AggregateBlock(
                                snapshot: snapshot,
                                index: index,
                                tv: -1,
                              );
                            },
                            separatorBuilder: (context, index) => const Divider(
                                  height: 5,
                                ),
                            itemCount: snapshot.data!.length);
                      }
                    }),
              ),
              const SizedBox(
                height: 8,
              ),
              Text('Airing Right Now', style: style1),
              const SizedBox(
                height: 8,
              ),
              Container(
                height: 230,
                child: FutureBuilder(
                    future: onTheAir,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return AggregateBlock(
                                snapshot: snapshot,
                                index: index,
                                tv: -1,
                              );
                            },
                            separatorBuilder: (context, index) => const Divider(
                                  height: 5,
                                ),
                            itemCount: snapshot.data!.length);
                      }
                    }),
              ),
              const SizedBox(
                height: 8,
              ),
              Text('Top Rated In TV', style: style1),
              const SizedBox(
                height: 8,
              ),
              Container(
                height: 230,
                child: FutureBuilder(
                    future: tvTopRated,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return AggregateBlock(
                                snapshot: snapshot,
                                index: index,
                                tv: -1,
                              );
                            },
                            separatorBuilder: (context, index) => const Divider(
                                  height: 5,
                                ),
                            itemCount: snapshot.data!.length);
                      }
                    }),
              ),
              const SizedBox(
                height: 8,
              ),
              Text('Popular With People', style: style1),
              const SizedBox(
                height: 8,
              ),
              Container(
                height: 230,
                child: FutureBuilder(
                    future: tvPopular,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return AggregateBlock(
                                snapshot: snapshot,
                                index: index,
                                tv: -1,
                              );
                            },
                            separatorBuilder: (context, index) => const Divider(
                                  height: 5,
                                ),
                            itemCount: snapshot.data!.length);
                      }
                    }),
              ),
              /********************************/
            ],
          ),
        ));
  }
}
