import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:sneakershoppingapp/constants/firebase_consts.dart';

class ProductsController extends GetxController {
  var currentIndex = 0.obs;
  var selected = 1.obs;
  var sizeBoxIndex = 0.obs;
  var cartflag = false.obs;
  var cartCounter = 0.obs;

  int get cartCount => cartCounter.value;

  void cartPlus() {
    cartCounter++;
  }

  String myText(dynamic data) {
    String text = 'hello';
    if (selected == 1) {
      text = data['p_desc'];
      // text = 'this is description';
    } else if (selected == 2) {
      text = 'This is delivery';
    } else {
      text = 'this is reviews';
    }
    return text;
  }

  // increaseQuantity({pname})async{
  //    var product = await firestore.collection(cartcollection).where('p_name',isEqualTo: pname).get();
  //    product.docs.upda
  // }
}
