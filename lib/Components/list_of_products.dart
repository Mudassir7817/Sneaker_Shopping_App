import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class ListOfProducts extends StatelessWidget {
  final String name;
  final String imagepath;
  final int price;
  final String rating;
  final String brandLogo;
  const ListOfProducts({
    Key? key,
    required this.name,
    required this.imagepath,
    required this.price,
    required this.brandLogo,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        top: 0,
        left: 0,
        child: Container(
          color: Colors.grey[100],
          width: Get.width * .8,
          height: Get.height * .37,
          child: Stack(
            children: [
              Positioned(
                  left: Get.height * .03,
                  bottom: Get.height * .03,
                  child: SizedBox(
                      width: Get.width * .7, child: Image.network(imagepath))),
              Positioned(
                  left: Get.height * .03,
                  bottom: Get.height * .31,
                  child: SizedBox(
                      width: Get.width * .18, child: Image.network(brandLogo))),
              Positioned(
                  right: Get.width * .05,
                  bottom: Get.height * .31,
                  child: const SizedBox(child: Icon(CupertinoIcons.heart))),
              Positioned(
                  left: Get.height * .28,
                  top: Get.height * .3,
                  child: Text(
                    '\$$price',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 22),
                  )),
              Positioned(
                  left: Get.height * .03,
                  top: Get.height * .28,
                  child: Text(
                    name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.grey[500]),
                  )),
              Positioned(
                  left: Get.height * .03,
                  top: Get.height * .31,
                  child: SmoothStarRating(
                    size: 24,
                    rating: double.parse(rating),
                    color: Colors.amber,
                    // filledIconData: Icons.blur_off,
                    onRatingChanged: (rating) {},
                    borderColor: Colors.amber,
                  )),
            ],
          ),
        ),
      ),
    ]);
  }
}
