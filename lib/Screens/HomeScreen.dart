// ignore: file_names
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sneakershoppingapp/Components/MyDrawer.dart';
import 'package:sneakershoppingapp/Components/list_of_products.dart';
import 'package:sneakershoppingapp/Controllers/ProductsScreenController.dart';
import 'package:sneakershoppingapp/Screens/ProductsScreen.dart';

import '../Services/FireBase_Services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var controller = Get.put(ProductsController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double ratingVal = 0;
  var selected = 'nike';
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        key: _scaffoldKey,
        drawer: const MyDrawer(),
        backgroundColor: Colors.grey[200],
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: Get.height * .14,
                  width: Get.width * .03,
                ),
                InkWell(
                  onTap: () {
                    _scaffoldKey.currentState!.openDrawer();
                  },
                  child: SizedBox(
                    width: Get.width * .07,
                    child: Image.asset('assets/images/menu.png'),
                  ),
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
                Padding(
                  padding: const EdgeInsets.only(right: 7.0),
                  child: SizedBox(
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
                ),
              ],
            ),
            Container(
              width: Get.width * .9,
              height: Get.height * .05,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                color: Colors.white,
              ),
              child: const Row(
                children: [
                  SizedBox(
                    width: 14,
                  ),
                  Icon(Icons.search),
                  SizedBox(
                    width: 14,
                  ),
                  Flexible(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: 'Search...',
                          fillColor: Colors.black,
                          border: InputBorder.none),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                SizedBox(width: Get.width * .05),
                GestureDetector(
                  onTap: () {
                    selected = "nike";
                  },
                  child: SizedBox(
                      width: Get.width * .17,
                      child: Image.asset('assets/images/nike-image.png')),
                ),
                SizedBox(width: Get.width * .07),
                GestureDetector(
                  onTap: () {
                    selected = "addidas";
                  },
                  child: SizedBox(
                      width: Get.width * .15,
                      child: Image.asset('assets/images/adidas.png')),
                ),
                SizedBox(width: Get.width * .07),
                SizedBox(
                    width: Get.width * .22,
                    child: Image.asset('assets/images/puma.webp')),
                SizedBox(width: Get.width * .03),
                SizedBox(
                    width: Get.width * .22,
                    child: Image.asset('assets/images/asics.png')),
              ],
            ),
            // }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        'SALE',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        'NEW ARRIVAL',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        'POPULAR',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
                StreamBuilder(
                    stream: FirebaseServices.getProducts(selected),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.data!.docs.isEmpty) {
                        return const Center(
                            child: Text(
                          "No products Available",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 32),
                        ));
                      } else {
                        var data = snapshot.data?.docs;
                        return SizedBox(
                          width: Get.width * .85,
                          height: Get.height * .68,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: data!.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.to(ProductsScreen(
                                    data: data[index],
                                  ));
                                },
                                child: Container(
                                  height: Get.height * .35,
                                  width: Get.width * 0.8,
                                  margin: const EdgeInsets.only(top: 10),
                                  child: ListOfProducts(
                                      name: data[index]['p_name'].toString(),
                                      imagepath: data[index]['p_images'][0],
                                      price: data[index]['p_price'],
                                      rating:
                                          data[index]['p_rating'].toString(),
                                      brandLogo: data[index]['p_logo']),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
