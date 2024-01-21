import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class testing extends StatelessWidget {
  const testing({super.key});

  @override
  Widget build(BuildContext context) {
    int rating = 0;
    return Scaffold(
      body: Center(
          child: SmoothStarRating(
        size: 28,
        color: Colors.amber,
        onRatingChanged: (rating) {
          rating = rating;
          log(rating.toString());
        },
        borderColor: Colors.amber,
      )),
    );
  }
}
