import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class Block extends StatelessWidget {
  String imageURL;
  Function()? onTap;
  Block({super.key, required this.imageURL, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6),
      height: MediaQuery.of(context).size.height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: GestureDetector(
          onTap: onTap,
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: imageURL,
            placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.purple,
                highlightColor: Colors.deepPurpleAccent,
                child: Card(
                  child: Column(),
                )),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
