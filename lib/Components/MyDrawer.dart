import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sneakershoppingapp/Screens/Edit_My_Profile.dart';
import 'package:sneakershoppingapp/Screens/HomeScreen.dart';
import 'package:sneakershoppingapp/Screens/MyCart.dart';
import 'package:sneakershoppingapp/Screens/MyWishListScreen.dart';
import 'package:sneakershoppingapp/Screens/Orders.dart';
import 'package:sneakershoppingapp/Services/FireBase_Services.dart';
import 'package:sneakershoppingapp/constants/firebase_consts.dart';

var data;

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  var currentPage = DrawerSections.home;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseServices.getUserData(currentuser?.uid),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            data = snapshot.data!.docs[0];
            log(data.toString());
            return Drawer(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height * .04,
                    ),
                    Container(
                      width: Get.width * .9,
                      height: Get.height * .25,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 38.0, left: 12.0),
                            child: SizedBox(
                              width: Get.width * .25,
                              height: Get.height * .11,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network(
                                  data['picture Url'],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 18.0, left: 12),
                            child: Text(
                              data['name'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0, left: 12),
                            child: Text(
                              data['email'],
                              style: const TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    ),
                    const Divider(),
                    myDrawerList()
                  ],
                ),
              ),
            );
          }
        });
  }

  Widget myDrawerList() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            myListItems(1, "Home", CupertinoIcons.home,
                currentPage == DrawerSections.home ? true : false),
            myListItems(2, "My Profile", CupertinoIcons.person,
                currentPage == DrawerSections.myprofile ? true : false),
            myListItems(3, "My Wish List", CupertinoIcons.heart,
                currentPage == DrawerSections.mywishlist ? true : false),
            myListItems(4, "My Cart", CupertinoIcons.cart,
                currentPage == DrawerSections.mycart ? true : false),
            myListItems(5, "Orders", CupertinoIcons.ticket,
                currentPage == DrawerSections.myorders ? true : false),
          ],
        ),
      ),
    );
  }

  Widget myListItems(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Get.back();
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.home;
            } else if (id == 2) {
              currentPage = DrawerSections.myprofile;
            } else if (id == 3) {
              currentPage = DrawerSections.mywishlist;
            } else if (id == 4) {
              currentPage = DrawerSections.mycart;
            } else if (id == 5) {
              currentPage = DrawerSections.myorders;
            }
          });
          navigateTheScreen(currentPage);
        },
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            children: [
              Expanded(
                // flex: 1,
                child: Icon(
                  icon,
                  size: 25,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateTheScreen(DrawerSections sections) {
    switch (sections) {
      case DrawerSections.home:
        Get.to(() => const HomeScreen());
        break;
      case DrawerSections.myprofile:
        Get.to(() => const EditMyProfile());
        break;
      case DrawerSections.mywishlist:
        Get.to(() => const MyWishList());
        break;
      case DrawerSections.mycart:
        Get.to(() => const MyCart());
        break;
      case DrawerSections.myorders:
        Get.to(() => const MyOrders());
        break;
    }
  }
}

enum DrawerSections {
  home,
  myprofile,
  mywishlist,
  mycart,
  myorders,
}
