import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moviedb/API/add_to_list.dart';
import 'package:moviedb/API/endpoints.dart';
import 'package:moviedb/API/serverCalls.dart';
import 'package:moviedb/Models/Movies.dart' as Movies;
import 'package:moviedb/Screens/SearchScreen.dart';
import 'package:moviedb/util/AggregateBlock.dart';
import 'package:moviedb/util/Block.dart';
import 'package:moviedb/util/style.dart';
import 'package:moviedb/Models/MovieReviews.dart' as MovieReviews;
import 'package:galleryimage/galleryimage.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shimmer/shimmer.dart';
import '../../util/loading_animations.dart';

class MovieDetailsScreen extends StatefulWidget {
  num id;
  MovieDetailsScreen({super.key, required this.id});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late Future movieDetails;
  late Future<List<Movies.Results>> similar;
  late Future<List<Movies.Results>> recommendation;
  late Future<List<MovieReviews.Results>> reviews;
  late Future<List<String>> imageUrls;
  late double pieValue;
  bool isLiked = false;
  bool isInWatchlist = false;
  @override
  void initState() {
    movieDetails = ServerCalls().getMovieDetails(widget.id.toString());
    similar =
        ServerCalls().getMoviesAdditionalData(widget.id.toString(), 'similar');
    recommendation = ServerCalls()
        .getMoviesAdditionalData(widget.id.toString(), 'recommendations');
    reviews = ServerCalls().getMovieReviews(widget.id.toString());
    imageUrls = ServerCalls().getImageUrls(widget.id.toString(), 'movie');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                  (route) => route.isFirst,
                );
              },
              icon: const Icon(Icons.search_outlined)),
          IconButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              icon: const Icon(Icons.home)),
        ],
      ),
      body: Container(
        color: Colors.purple[50],
        child: FutureBuilder(
            future: movieDetails,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: fourRotatingDots,
                );
              } else {
                pieValue = snapshot.data!.voteAverage;
                String? imgUrl = snapshot.data.backdropPath;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                          height: 300,
                          child: Stack(
                            children: [
                              Center(
                                child: Block(
                                    imageURL: (imgUrl == null)
                                        ? Endpoints.blankImage
                                        : Endpoints.baseImg + imgUrl),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(40),
                                    topLeft: Radius.circular(40),
                                  ),
                                  child: Container(
                                    color: Colors.purple[200],
                                    height: 60,
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CircularPercentIndicator(
                                          radius: 25,
                                          animation: true,
                                          animationDuration: 2500,
                                          lineWidth: 5.0,
                                          percent: (pieValue / 10),
                                          center: Text(
                                              pieValue.toStringAsPrecision(3),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              )),
                                          circularStrokeCap:
                                              CircularStrokeCap.butt,
                                          backgroundColor: Colors.white,
                                          progressColor: Colors.black,
                                        ),
                                        IconButton(
                                            onPressed: () async {
                                              final result = await AddToList()
                                                  .addToLiked(
                                                      'movie',
                                                      snapshot.data.id
                                                          .toString());
                                              if (result == 'true') {
                                                setState(() {
                                                  isLiked = true;
                                                });
                                              }
                                            },
                                            icon: isLiked
                                                ? const Icon(
                                                    CupertinoIcons.heart_fill)
                                                : const Icon(
                                                    CupertinoIcons.heart)),
                                        IconButton(
                                          onPressed: () async {
                                            final result = await AddToList()
                                                .addToWatchlist(
                                                    'movie',
                                                    snapshot.data.id
                                                        .toString());
                                            if (result == 'true') {
                                              setState(() {
                                                isInWatchlist = true;
                                              });
                                            }
                                          },
                                          icon: (isInWatchlist)
                                              ? const Icon(Icons.bookmark)
                                              : const Icon(
                                                  Icons.bookmark_border),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      ListTile(
                        leading: const Text(''),
                        title: Text(
                          snapshot.data!.originalTitle.toString(),
                          style: style1,
                        ),
                        subtitle: Text(snapshot.data!.tagline.toString()),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          margin: constMargin,
                          child: Text(snapshot.data!.overview.toString()),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        height: 50,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.genres.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(left: 25),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: elevatedButtonStyle,
                                child: Text(
                                  snapshot.data.genres[index].name,
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(
                            height: 20,
                            thickness: 10,
                          ),
                        ),
                      ),
                      Text(
                        'Reviews',
                        style: style1,
                      ),
                      Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        child: FutureBuilder(
                            future: reviews,
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(child: fourRotatingDots);
                              } else {
                                if (snapshot.data!.isEmpty) {
                                  return const Center(
                                      child: Text('No Reviews Available'));
                                }
                                return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    padding: const EdgeInsets.only(top: 8),
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        margin: const EdgeInsets.all(15),
                                        child: Card(
                                          color: Colors.purple[500],
                                          child: ListTile(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            leading: const Icon(
                                              Icons.person,
                                              color: Colors.white,
                                            ),
                                            title: Text(
                                              (snapshot.data![index].author ==
                                                      null)
                                                  ? 'Anonymous'
                                                  : snapshot.data![index].author
                                                      .toString(),
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            subtitle: Text(
                                              (snapshot.data![index].content ==
                                                      null)
                                                  ? 'No Content Available'
                                                  : '${snapshot.data![index].content.toString().replaceAll('\r', '').replaceAll('\n', ' ').substring(0, min(200, snapshot.data![index].content.toString().length)).replaceAll('\n', ' ')}...',
                                              style: style2,
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              }
                            }),
                      ),
                      Text(
                        'Images',
                        style: style1,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        child: FutureBuilder(
                          future: imageUrls,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(child: fourRotatingDots);
                            } else {
                              if (snapshot.data!.isEmpty) {
                                return Container(
                                  height: 150,
                                  child: const Center(
                                      child: Text('No Images Available')),
                                );
                              }
                              return GalleryImage(
                                imageUrls: snapshot.data!,
                                numOfShowImages: min(snapshot.data!.length, 3),
                                colorOfNumberWidget: Colors.purple[300],
                                titleGallery: 'Images',
                                loadingWidget: Shimmer.fromColors(
                                    baseColor: Colors.purple,
                                    highlightColor: Colors.deepPurpleAccent,
                                    child: const Card()),
                                errorWidget: const Icon(Icons.error),
                              );
                            }
                          },
                        ),
                      ),
                      Text(
                        'Similar',
                        style: style1,
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        height: 230,
                        child: FutureBuilder(
                            future: similar,
                            builder: (context, snapshot) {
                              if (snapshot.data!.isEmpty) {
                                return const Center(
                                    child: Text('No Similar Movies Available'));
                              }
                              if (snapshot.hasData &&
                                  snapshot.data != null &&
                                  snapshot.data!.isNotEmpty) {
                                return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      return AggregateBlock(
                                        snapshot: snapshot,
                                        index: index,
                                        tv: 0,
                                      );
                                    });
                              } else {
                                return Center(
                                  child: fourRotatingDots,
                                );
                              }
                            }),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Recommendation',
                        style: style1,
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        height: 230,
                        child: FutureBuilder(
                            future: recommendation,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data!.isEmpty) {
                                  return const Center(
                                      child:
                                          Text('No Recommendations Available'));
                                }
                                return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      return AggregateBlock(
                                        snapshot: snapshot,
                                        index: index,
                                        tv: 0,
                                      );
                                    });
                              } else {
                                return Center(
                                  child: fourRotatingDots,
                                );
                              }
                            }),
                      ),
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}
