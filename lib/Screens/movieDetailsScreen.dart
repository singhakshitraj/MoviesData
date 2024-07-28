import 'dart:math';
import 'package:flutter/material.dart';
import 'package:moviedb/API/endpoints.dart';
import 'package:moviedb/API/serverCalls.dart';
import 'package:moviedb/Models/Movies.dart' as Movies;
import 'package:moviedb/util/AggregateBlock.dart';
import 'package:moviedb/util/Block.dart';
import 'package:moviedb/util/style.dart';
import 'package:moviedb/Models/MovieReviews.dart' as MovieReviews;
import 'package:galleryimage/galleryimage.dart';
import 'package:shimmer/shimmer.dart';

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
      appBar: AppBar(),
      body: FutureBuilder(
          future: movieDetails,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 300,
                      child: Block(
                          imageURL: Endpoints.baseImg +
                              snapshot.data!.backdropPath.toString()),
                    ),
                    ListTile(
                      leading: const Text(''),
                      title: Text(
                        snapshot.data!.originalTitle.toString(),
                        style: style1,
                      ),
                      subtitle: Text(snapshot.data!.tagline.toString()),
                    ),
                    Container(
                      margin: constMargin,
                      child: Text(snapshot.data!.overview.toString()),
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
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else {
                              return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.only(top: 8),
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height: 150,
                                      margin: const EdgeInsets.all(15),
                                      child: Center(
                                        child: ListTile(
                                          tileColor: Colors.purple,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          leading: Image.asset(
                                              'lib/Assets/contact.png'),
                                          title: Text(
                                            snapshot.data![index].author
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          subtitle: Text(
                                            '${snapshot.data![index].content.toString().substring(0, min(200, snapshot.data![index].content.toString().length))}...',
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
                      //height: 150,
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
                                      tv: 0,
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
                                      tv: 0,
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
