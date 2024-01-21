import 'package:get/get.dart';

class MyCartController extends GetxController {
  var numOfProducts = 1.obs;

  void increaseProducts() {
    numOfProducts++;
  }
}
