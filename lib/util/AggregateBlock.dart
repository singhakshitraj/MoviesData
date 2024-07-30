import 'package:flutter/material.dart';
import 'package:moviedb/API/endpoints.dart';
import 'package:moviedb/Screens/movieDetailsScreen.dart';
import 'package:moviedb/Screens/tvSeriesDetailsScreen.dart';
import 'package:moviedb/util/Block.dart';
import 'package:page_animation_transition/animations/right_to_left_faded_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

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
        imageURL: (widget.snapshot.data[widget.index].posterPath == null)
            ? Endpoints.blankImage
            : Endpoints.baseImg +
                widget.snapshot.data![widget.index].posterPath.toString(),
        onTap: () {
          if (widget.tv != null && widget.tv == -1) {
            Navigator.of(context).push(PageAnimationTransition(
              page: TvSeriesDetailsScreen(
                id: widget.snapshot.data[widget.index].id,
              ),
              pageAnimationType: RightToLeftFadedTransition(),
            ));
          } else if (widget.tv != null && widget.tv == 0 ||
              widget.snapshot.data![widget.index].mediaType.toString() ==
                  'movie') {
            Navigator.of(context).push(PageAnimationTransition(
              page: MovieDetailsScreen(
                id: widget.snapshot.data[widget.index].id,
              ),
              pageAnimationType: RightToLeftFadedTransition(),
            ));
          } else if (widget.snapshot.data![widget.index].mediaType.toString() ==
              'tv') {
            Navigator.of(context).push(PageAnimationTransition(
              page: TvSeriesDetailsScreen(
                id: widget.snapshot.data[widget.index].id,
              ),
              pageAnimationType: RightToLeftFadedTransition(),
            ));
          }
        },
      ),
    );
  }
}
