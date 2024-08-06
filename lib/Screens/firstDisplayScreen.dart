import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:moviedb/API/endpoints.dart';
import 'package:moviedb/API/serverCalls.dart';
import 'package:moviedb/Models/Movies.dart' as movies;
import 'package:moviedb/Models/People.dart' as people;
import 'package:moviedb/Models/tvSeries.dart' as tv_series;
import 'package:moviedb/Screens/SearchScreen.dart';
import 'package:moviedb/util/AggregateBlock.dart';
import 'package:moviedb/util/loading_animations.dart';
import 'package:moviedb/util/style.dart';
import 'package:page_animation_transition/animations/right_to_left_faded_transition.dart';
import 'package:shimmer/shimmer.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

class FirstDisplayScreen extends StatefulWidget {
  const FirstDisplayScreen({super.key});

  @override
  State<FirstDisplayScreen> createState() => _FirstDisplayScreenState();
}

class _FirstDisplayScreenState extends State<FirstDisplayScreen> {
  late Future<List<movies.Results>> trendingAll;
  late Future<List<movies.Results>> trendingMovie;
  late Future<List<movies.Results>> trendingTv;
  late Future<List<people.Results>> trendingPeople;
  late Future<List<tv_series.Results>> airingToday;
  late Future<List<tv_series.Results>> onTheAir;
  late Future<List<tv_series.Results>> tvPopular;
  late Future<List<tv_series.Results>> tvTopRated;
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
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(PageAnimationTransition(
                    page: const SearchScreen(),
                    pageAnimationType: RightToLeftFadedTransition(),
                  ));
                },
                icon: const Icon(Icons.search)),
          ],
          elevation: 11,
          title: const Text(
            'Welcome !! ',
            style:
                TextStyle(wordSpacing: 1.5, letterSpacing: 1.5, fontSize: 25),
          ),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              Container(
                height: 30,
                color: const Color(0xff98e4e4),
              ),
              ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Image.asset('lib/Assets/cinema.jpeg')),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.home),
                      title: Text(
                        'HOME',
                        style: style4,
                      ),
                    ),
                    ListTile(
                      leading: const Icon(CupertinoIcons.heart_fill),
                      title: Text(
                        'LIKED',
                        style: style4,
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.bookmark),
                      title: Text(
                        'WATCHLIST',
                        style: style4,
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: Text(
                        'SETTINGS',
                        style: style4,
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.contact_page),
                      title: Text(
                        'ABOUT',
                        style: style4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            color: Colors.purple[50],
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.60,
                  child: FutureBuilder(
                      future: trendingAll,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: fourRotatingDots);
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
                                autoPlay: true,
                              ));
                        }
                      }),
                ),
                Text('Trending In Movies', style: style1),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
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
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                    height: 5,
                                  ),
                              itemCount: snapshot.data!.length);
                        } else {
                          return fourRotatingDots;
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
                SizedBox(
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
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                    height: 5,
                                  ),
                              itemCount: snapshot.data!.length);
                        } else {
                          return fourRotatingDots;
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
                SizedBox(
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
                                      child: SizedBox(
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
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                    height: 5,
                                  ),
                              itemCount: snapshot.data!.length);
                        } else {
                          return fourRotatingDots;
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
                SizedBox(
                  height: 230,
                  child: FutureBuilder(
                      future: airingToday,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: fourRotatingDots);
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
                              separatorBuilder: (context, index) =>
                                  const Divider(
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
                SizedBox(
                  height: 230,
                  child: FutureBuilder(
                      future: onTheAir,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: fourRotatingDots);
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
                              separatorBuilder: (context, index) =>
                                  const Divider(
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
                SizedBox(
                  height: 230,
                  child: FutureBuilder(
                      future: tvTopRated,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: fourRotatingDots);
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
                              separatorBuilder: (context, index) =>
                                  const Divider(
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
                SizedBox(
                  height: 230,
                  child: FutureBuilder(
                      future: tvPopular,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: fourRotatingDots);
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
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                    height: 5,
                                  ),
                              itemCount: snapshot.data!.length);
                        }
                      }),
                ),
                /********************************/
              ],
            ),
          ),
        ));
  }
}
