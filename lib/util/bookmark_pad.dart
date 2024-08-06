import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

Widget bookmarkPad(double pieValue, BuildContext context) {
  return Align(
    alignment: Alignment.bottomRight,
    child: ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(40),
        topLeft: Radius.circular(40),
      ),
      child: Container(
        color: Colors.purple[200],
        height: 60,
        width: MediaQuery.of(context).size.width * 0.5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircularPercentIndicator(
              radius: 25,
              animation: true,
              animationDuration: 2500,
              lineWidth: 5.0,
              percent: (pieValue / 10),
              center: Text(pieValue.toStringAsPrecision(3),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  )),
              circularStrokeCap: CircularStrokeCap.butt,
              backgroundColor: Colors.white,
              progressColor: Colors.black,
            ),
            const Icon(CupertinoIcons.heart_fill),
            const Icon(Icons.bookmark),
          ],
        ),
      ),
    ),
  );
}
