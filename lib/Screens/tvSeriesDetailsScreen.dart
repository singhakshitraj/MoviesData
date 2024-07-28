import 'dart:math';

import 'package:flutter/material.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:moviedb/API/endpoints.dart';
import 'package:moviedb/API/serverCalls.dart';
import 'package:moviedb/util/AggregateBlock.dart';
import 'package:moviedb/util/Block.dart';
import 'package:moviedb/util/style.dart';
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
        title: Text(''),
        centerTitle: true,
        titleSpacing: 1.5,
      ),
      body: FutureBuilder(
          future: tvSeriesDetails,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 300,
                      child: Block(
                          imageURL: Endpoints.baseImg +
                              snapshot.data.backdropPath.toString()),
                    ),
                    ListTile(
                      leading: const Text(''),
                      title: Text(
                        snapshot.data!.originalName.toString(),
                        style: style1,
                      ),
                      subtitle: Text(snapshot.data!.tagline.toString()),
                    ),
                    Container(
                      margin: constMargin,
                      child: Text(snapshot.data!.overview.toString()),
                    ),
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
                      'Last Episode To Air',
                      style: style1,
                    ),
                    const SizedBox(height: 9),
                    Card(
                      child: Column(
                        children: [
                          ListTile(
                            //tileColor: Colors.yellow[100],
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
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
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
                            if (snapshot.hasData) {
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
                              return const Center(
                                child: CircularProgressIndicator(),
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
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }
}
