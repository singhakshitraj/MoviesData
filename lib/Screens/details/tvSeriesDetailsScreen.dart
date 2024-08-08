import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:moviedb/API/list_operations.dart';
import 'package:moviedb/API/endpoints.dart';
import 'package:moviedb/API/serverCalls.dart';
import 'package:moviedb/Screens/SearchScreen.dart';
import 'package:moviedb/util/AggregateBlock.dart';
import 'package:moviedb/util/Block.dart';
import 'package:moviedb/util/loading_animations.dart';
import 'package:moviedb/util/style.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shimmer/shimmer.dart';

class TvSeriesDetailsScreen extends StatefulWidget {
  num id;
  TvSeriesDetailsScreen({super.key, required this.id});

  @override
  State<TvSeriesDetailsScreen> createState() => _TvSeriesDetailsScreenState();
}

class _TvSeriesDetailsScreenState extends State<TvSeriesDetailsScreen> {
  late Future tvSeriesDetails;
  late Future imageUrls;
  late Future similar;
  late Future recommendation;
  late double pieValue;
  bool isLiked = false;
  bool isInWatchlist = false;
  @override
  void initState() {
    tvSeriesDetails = ServerCalls().getTvSeriesDetails(widget.id.toString());
    similar =
        ServerCalls().getTvSeriesAdditional(widget.id.toString(), 'similar');
    recommendation = ServerCalls()
        .getTvSeriesAdditional(widget.id.toString(), 'recommendations');
    imageUrls = ServerCalls().getImageUrls(widget.id.toString(), 'tv');
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
            future: tvSeriesDetails,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: fourRotatingDots);
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
                                                fontSize: 12,
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
                                                      'tv',
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
                                            final String result =
                                                await AddToList()
                                                    .addToWatchlist(
                                                        'tv',
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
                          snapshot.data!.originalName.toString(),
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
                      Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        height: 50,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.genres.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(left: 15),
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
                        'Last Episode To Air',
                        style: style1,
                      ),
                      const SizedBox(height: 15),
                      Card(
                        color: Colors.purple[200],
                        margin: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          bottom: 10,
                          top: 10,
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Text(
                                snapshot.data.lastEpisodeToAir.episodeNumber
                                    .toString(),
                              ),
                              title: Text(
                                snapshot.data.lastEpisodeToAir.name.toString(),
                                style: style1,
                              ),
                              subtitle: Text(
                                  'Date Aired - ${snapshot.data.lastEpisodeToAir.airDate}'),
                            ),
                            Container(
                                margin: constMargin.add(
                                  const EdgeInsets.only(bottom: 24),
                                ),
                                child: Text(
                                  snapshot.data.lastEpisodeToAir.overview
                                      .toString(),
                                )),
                          ],
                        ),
                      ),
                      Text('Images', style: style1),
                      const SizedBox(height: 12),
                      Container(
                        child: FutureBuilder(
                          future: imageUrls,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Container(child: fourRotatingDots);
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
                      const SizedBox(height: 12),
                      Text('Similar',
                          style: style1, textAlign: TextAlign.center),
                      const SizedBox(height: 12),
                      Container(
                        height: 230,
                        child: FutureBuilder(
                            future: similar,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data!.isEmpty) {
                                  return const Center(
                                      child:
                                          Text('No Similar Items Available'));
                                }
                                return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      return AggregateBlock(
                                        snapshot: snapshot,
                                        index: index,
                                        tv: -1,
                                      );
                                    });
                              } else {
                                return Center(
                                  child: fourRotatingDots,
                                );
                              }
                            }),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Recommendation',
                        style: style1,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
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
                                        tv: -1,
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
