
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class StaticRatingBar extends StatelessWidget {

  final double rating;

  StaticRatingBar(this.rating);

  @override
  Widget build(BuildContext context) {
    return RatingBar(
      itemSize: 20,
      initialRating: rating / 2.0,
      direction: Axis.horizontal,
      ignoreGestures: true,
      allowHalfRating: true,
      itemCount: 5,
      ratingWidget: RatingWidget(
        full: Icon(Icons.star, color: Colors.yellow, size: 20,),
        half: Icon(Icons.star_half, color: Colors.yellow, size: 20),
        empty: Icon(Icons.star_border),
      ),
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }
}