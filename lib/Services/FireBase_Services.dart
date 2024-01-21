import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sneakershoppingapp/constants/firebase_consts.dart';

class FirebaseServices {
  static getUserData(uid) {
    return firestore
        .collection(usercollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  //get products according to category

  static getProducts(category) {
    return firestore
        .collection(productcollection)
        .where('p_categroy', isEqualTo: category)
        .snapshots();
  }

  static addToCart({img, brandname, pname, size, qty, price}) async {
    await firestore.collection(cartcollection).doc().set({
      'image': img,
      'brand_name': brandname,
      'price': price,
      'product_name': pname,
      'size': size,
      'quantity': qty,
      'added_by': currentuser!.uid,
    });
  }

  //Check if the product is available
  static Future<bool> checkProductAvailablity(data, {pname}) async {
    QuerySnapshot querySnapshot = await firestore
        .collection(cartcollection)
        .where('p_name', isEqualTo: pname)
        .get();
    bool isAvailable = querySnapshot.docs.isNotEmpty;
    return isAvailable;
  }

  static getCart(uid) {
    return firestore
        .collection(cartcollection)
        .where('added_by', isEqualTo: currentuser!.uid)
        .snapshots();
  }
}
