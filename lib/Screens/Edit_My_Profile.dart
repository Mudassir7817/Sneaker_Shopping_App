import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sneakershoppingapp/Components/MyDrawer.dart';

import 'package:sneakershoppingapp/Firebase/Profile_controller.dart';

class EditMyProfile extends StatelessWidget {
  const EditMyProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    controller.namecontroller.text = data['name'];
    return Scaffold(
        body: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  CupertinoIcons.back,
                  size: 30,
                )),
            SizedBox(
              height: Get.height * .14,
              width: Get.width * .25,
            ),
            const Text(
              'My Profile',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          height: Get.height * .03,
        ),
        SizedBox(
          width: Get.width * .5,
          height: Get.height * .25,
          child: ClipRRect(
            // fit: BoxFit.cover,
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              data['picture Url'],
            ),
          ),
        ),
        SizedBox(
          height: Get.height * .05,
        ),
        ElevatedButton.icon(
            onPressed: () {
              log('in edit picture button');
              controller.changeImage();
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black)),
            icon: const Icon(
              CupertinoIcons.pencil,
              color: Colors.white,
            ),
            label: const Text(
              "Edit Picture",
              style: TextStyle(color: Colors.white),
            )),
        Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            children: [
              TextFormField(
                controller: controller.namecontroller,
                decoration: const InputDecoration(
                    hintText: "name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(22)))),
              ),
              SizedBox(
                height: Get.height * .02,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: data['email'],
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(22)))),
              ),
              SizedBox(
                height: Get.height * .02,
              ),
              ElevatedButton(
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(500, 50)),
                    backgroundColor: MaterialStateProperty.all(Colors.black)),
                onPressed: () async {
                  await controller.uploadProfileImage();
                  await controller.updateProfile(
                      pictureUrl: controller.imagePathLink,
                      name: controller.namecontroller.text);
                },
                child: const Text(
                  "Save",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              )
            ],
          ),
        )
      ],
    ));
  }
}
