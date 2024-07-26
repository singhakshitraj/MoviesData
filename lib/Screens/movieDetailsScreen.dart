import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviedb/API/endpoints.dart';
import 'package:moviedb/API/serverCalls.dart';
import 'package:moviedb/Models/Movies.dart' as Movies;
import 'package:moviedb/util/AggregateBlock.dart';
import 'package:moviedb/util/Block.dart';
import 'package:moviedb/util/style.dart';

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
  @override
  void initState() {
    movieDetails = ServerCalls().getMovieDetails(widget.id.toString());
    similar =
        ServerCalls().getMoviesAdditionalData(widget.id.toString(), 'similar');
    recommendation = ServerCalls()
        .getMoviesAdditionalData(widget.id.toString(), 'recommendations');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 600,
              child: FutureBuilder(
                  future: movieDetails,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircleAvatar(),
                      );
                    } else {
                      return Column(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Block(
                                imageURL: Endpoints.baseImg +
                                    snapshot.data!.backdropPath.toString()),
                          ),
                          Expanded(
                            flex: 1,
                            child: ListTile(
                              leading: Text(''),
                              title:
                                  Text(snapshot.data!.originalTitle.toString()),
                              subtitle: Text(snapshot.data!.tagline.toString()),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              margin: constMargin,
                              child: Text(snapshot.data!.overview.toString()),
                            ),
                          ),
                          SizedBox(height: 8),
                        ],
                      );
                    }
                  }),
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
            SizedBox(
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
      ),
    );
  }
}
