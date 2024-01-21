import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sneakershoppingapp/constants/firebase_consts.dart';

class ProfileController extends GetxController {
  var imagepath = ''.obs;
  var imagePathLink = '';
  TextEditingController namecontroller = TextEditingController();

  changeImage() async {
    try {
      log('in change image');
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      } else {
        imagepath.value = image.path;
        log(imagepath.value);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  uploadProfileImage() async {
    var filename = basename(imagepath.value);
    var destination = 'images/Recents/${currentuser!.uid}/$filename';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(imagepath.value));
    imagePathLink = await ref.getDownloadURL();
  }

  updateProfile({name, pictureUrl}) async {
    var store = firestore.collection(usercollection).doc(currentuser!.uid);
    await store.set({
      'name': name,
      'picture Url': pictureUrl,
    }, SetOptions(merge: true));
  }

  updateCart() async {
    log('in updateCart()');
    // var store = firestore.collection(productcollection).doc(dc.id);
    // await store.update({'incart': true});
  }
}
