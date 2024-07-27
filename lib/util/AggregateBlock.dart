import 'package:flutter/material.dart';
import 'package:moviedb/API/endpoints.dart';
import 'package:moviedb/Screens/movieDetailsScreen.dart';
import 'package:moviedb/Screens/tvSeriesDetailsScreen.dart';
import 'package:moviedb/util/Block.dart';

class AggregateBlock extends StatefulWidget {
  num? tv;
  num index;
  AsyncSnapshot snapshot;
  AggregateBlock(
      {super.key, required this.snapshot, required this.index, this.tv});

  @override
  State<AggregateBlock> createState() => _AggregateBlockState();
}

class _AggregateBlockState extends State<AggregateBlock> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Block(
        imageURL: Endpoints.baseImg +
            widget.snapshot.data![widget.index].posterPath.toString(),
        onTap: () {
          if (widget.tv != null && widget.tv == -1) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return TvSeriesDetailsScreen(
                id: widget.snapshot.data[widget.index].id,
              );
            }));
          } else if (widget.tv != null && widget.tv == 0 ||
              widget.snapshot.data![widget.index].mediaType.toString() ==
                  'movie') {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return MovieDetailsScreen(
                id: widget.snapshot.data[widget.index].id,
              );
            }));
          } else if (widget.snapshot.data![widget.index].mediaType.toString() ==
              'tv') {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return TvSeriesDetailsScreen(
                id: widget.snapshot.data[widget.index].id,
              );
            }));
          }
        },
      ),
    );
  }
}
