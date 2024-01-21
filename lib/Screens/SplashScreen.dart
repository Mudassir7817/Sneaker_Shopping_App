import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sneakershoppingapp/Firebase/auth_controller.dart';
import 'package:sneakershoppingapp/Screens/HomeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: 250,
                child: Image.asset('assets/images/nike png.png'),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            const Text(
              'Just Do It',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              'Shop Best And Premium Quality Sneakers',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () async {
                User? user = await controller.signInWithGoogle();
                if (user != null) {
                  controller.isloading(true);
                  log(user.toString());
                  controller.storeUserDataInFirestore(user);
                  Get.to(() => const HomeScreen());
                }
              },
              child: Obx(
                () => controller.isloading.value
                    ? const CircularProgressIndicator()
                    : Container(
                        height: Get.height * .06,
                        width: Get.width * .8,
                        decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: const Center(
                          child: Text(
                            'Sign In',
                            style: TextStyle(color: Colors.white, fontSize: 23),
                          ),
                        ),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
