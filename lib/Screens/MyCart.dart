import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sneakershoppingapp/Controllers/MyCart_controller.dart';
import 'package:sneakershoppingapp/Services/FireBase_Services.dart';
import 'package:sneakershoppingapp/constants/firebase_consts.dart';

class MyCart extends StatelessWidget {
  const MyCart({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(MyCartController());
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseServices.getCart(currentuser!.uid),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              var data = snapshot.data!.docs;
              log('this is data: $data');
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                          child: const Icon(Icons.arrow_back),
                        ),
                      ),
                      SizedBox(
                        width: Get.width * .38,
                      ),
                      const Text(
                        'Cart',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Container(
                                height: Get.height * .15,
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: Get.width * .2,
                                          height: Get.height * .07,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            color: Colors.grey[200],
                                          ),
                                          child: Center(
                                              child: SizedBox(
                                            width: Get.width * .15,
                                            child: Image.network(
                                                "${(data[index]['image'] as List)[0].replaceAll('[', '').replaceAll(']', '')}"),
                                          )),
                                        ),
                                        SizedBox(width: Get.width * .1),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${data[index]['brand_name']}",
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                            ),
                                            Text(
                                              "${data[index]['product_name']}",
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.all(0),
                                              child: Row(
                                                children: [
                                                  Text('Size '),
                                                  Text(' 34')
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: Get.height * .016),
                                    Obx(
                                      () => Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: Get.width * .28,
                                          ),
                                          Container(
                                            width: Get.width * .1,
                                            height: Get.height * .04,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.grey[200],
                                            ),
                                            child: const Center(
                                              child: Text(
                                                '−',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: Get.width * .02),
                                          Text(
                                            controller.numOfProducts.toString(),
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                          SizedBox(width: Get.width * .02),
                                          Container(
                                            width: Get.width * .1,
                                            height: Get.height * .04,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.blue,
                                            ),
                                            child: Center(
                                              child: GestureDetector(
                                                onTap: () {
                                                  controller.increaseProducts();
                                                },
                                                child: const Text(
                                                  '+',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: Get.width * .3),
                                          Text(
                                            "\$${data[index]['price']}",
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12)
                            ],
                          );
                        },
                      ),
                    ),
                  )
                ],
              );
            }
          }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ElevatedButton(
            onPressed: () {},
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.blue)),
            child: const Text(
              'Checkout',
              style: TextStyle(color: Colors.white),
            )),
      ),
    );
  }
}
