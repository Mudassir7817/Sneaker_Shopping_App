import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:sneakershoppingapp/Controllers/ProductsScreenController.dart';
import 'package:sneakershoppingapp/Firebase/Profile_controller.dart';
import 'package:sneakershoppingapp/Services/FireBase_Services.dart';

class ProductsScreen extends StatefulWidget {
  final dynamic data;
  ProductsScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  var controller = Get.put(ProductsController());
  String mydata = 'Hey Hello';
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductsController());
    return Obx(
      () => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: Get.height * .14,
                    width: Get.width * .03,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: SizedBox(
                        width: Get.width * .07,
                        child: const Icon(Icons.arrow_back)),
                  ),
                  SizedBox(
                    // height: Get.height * .14,
                    width: Get.width * .3,
                  ),
                  const Text(
                    'Explore',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    // height: Get.height * .14,
                    width: Get.width * .3,
                  ),
                  SizedBox(
                    width: Get.width * .07,
                    child: Stack(children: [
                      Positioned(
                          child: Image.asset('assets/images/shoppingbag.png')),
                      Positioned(
                          bottom: 1,
                          right: 12,
                          child: Container(
                            width: Get.width * .035,
                            height: Get.height * .035,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.black),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 5.0, left: 2.5),
                              child: Text(
                                controller.cartCounter.toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                    ]),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                height: Get.height * .3,
                child: PageView.builder(
                  onPageChanged: (index) {
                    controller.currentIndex.value = index;
                  },
                  itemCount: widget.data['p_images'].length,
                  itemBuilder: (BuildContext context, int index) {
                    return Image.network(
                      widget.data['p_images']
                          [index % widget.data['p_images'].length],
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              SizedBox(
                height: Get.height * .01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < widget.data['p_images'].length; i++)
                    buildIndicator(controller.currentIndex == i)
                ],
              ),
              SizedBox(height: Get.height * .02),
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(width: Get.width * .04),
                    Text(
                      widget.data['p_name'],
                      style:
                          const TextStyle(fontSize: 19, color: Colors.black87),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmoothStarRating(
                          size: 22,
                          rating: double.parse(widget.data['p_rating']),
                          color: Colors.amber,
                          onRatingChanged: (rating) {},
                          borderColor: Colors.amber,
                        ),
                        Text(
                          '\$${widget.data['p_price']}',
                          style: const TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height * .02),
                    const Text(
                      'Select size',
                      style: TextStyle(fontSize: 16),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                            onTap: () {
                              controller.sizeBoxIndex.value = 1;
                            },
                            child: selectSizes(
                                39, controller.sizeBoxIndex.value == 1)),
                        GestureDetector(
                            onTap: () {
                              controller.sizeBoxIndex.value = 2;
                            },
                            child: selectSizes(
                                40, controller.sizeBoxIndex.value == 2)),
                        GestureDetector(
                            onTap: () {
                              controller.sizeBoxIndex.value = 3;
                            },
                            child: selectSizes(
                                41, controller.sizeBoxIndex.value == 3)),
                        GestureDetector(
                            onTap: () {
                              controller.sizeBoxIndex.value = 4;
                            },
                            child: selectSizes(
                                42, controller.sizeBoxIndex.value == 4)),
                        GestureDetector(
                            onTap: () {
                              controller.sizeBoxIndex.value = 5;
                            },
                            child: selectSizes(
                                43, controller.sizeBoxIndex.value == 5)),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            log('tapping on description');
                            controller.selected.value = 1;
                          },
                          child: Column(
                            children: [
                              const Text('DESCRIPTION',
                                  style: TextStyle(fontSize: 16)),
                              if (controller.selected.value == 1)
                                Container(
                                  height: Get.height * .002,
                                  width: Get.width * .2,
                                  color: Colors.blue,
                                )
                            ],
                          ),
                        ),
                        SizedBox(width: Get.width * .04),
                        GestureDetector(
                          onTap: () {
                            controller.selected.value = 2;
                          },
                          child: Column(
                            children: [
                              const Text('DELIVERY',
                                  style: TextStyle(fontSize: 16)),
                              if (controller.selected.value == 2)
                                Container(
                                  height: Get.height * .002,
                                  width: Get.width * .15,
                                  color: Colors.blue,
                                )
                            ],
                          ),
                        ),
                        SizedBox(width: Get.width * .04),
                        GestureDetector(
                          onTap: () {
                            controller.selected.value = 3;
                          },
                          child: Column(
                            children: [
                              const Text('REVIEWS',
                                  style: TextStyle(fontSize: 16)),
                              if (controller.selected.value == 3)
                                Container(
                                  height: Get.height * .002,
                                  width: Get.width * .15,
                                  color: Colors.blue,
                                )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * .02,
                    ),
                    Container(
                      child: Text(
                        controller.myText(widget.data),
                        style: const TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            shape: const CircleBorder(),
            onPressed: () async {
              controller.cartflag.value ? null : controller.cartPlus();
              controller.cartflag.value = true;
              FirebaseServices.addToCart(
                img: widget.data[0]['p_images'],
                brandname: widget.data['p_categroy'],
                pname: widget.data['p_name'],
                qty: 0,
                size: 0,
                price: widget.data['p_price'],
              );
              Timer(const Duration(seconds: 2), () {
                controller.cartflag.value = false;
              });
            },
            backgroundColor: Colors.blue,
            child: controller.cartflag.value
                ? const Icon(
                    Icons.done,
                    color: Colors.white,
                    size: 32,
                  )
                : const Icon(
                    CupertinoIcons.cart_badge_plus,
                    color: Colors.white,
                    size: 28,
                  )),
      ),
    );
  }

  Widget selectSizes(int size, bool isSelected) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: isSelected ? Get.width * .14 : Get.width * .12,
          height: isSelected ? Get.height * .14 : Get.height * .12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? Colors.blue : Colors.black,
            ),
          ),
          child: Center(
              child: Text(
            size.toString(),
            style: TextStyle(
                fontSize: isSelected ? 18 : 16,
                color: isSelected ? Colors.blue : Colors.black),
          )),
        )
      ],
    );
  }

  Widget buildIndicator(bool isSelected) {
    return Container(
      height: isSelected ? 10 : 8,
      width: isSelected ? 10 : 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? Colors.blue : Colors.grey,
      ),
    );
  }
}
