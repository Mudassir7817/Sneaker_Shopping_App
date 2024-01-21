import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
