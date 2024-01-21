import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sneakershoppingapp/constants/firebase_consts.dart';

class AuthController extends GetxController {
  var isloading = false.obs;
  Future<User?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    final UserCredential authresult =
        await FirebaseAuth.instance.signInWithCredential(credential);
    return authresult.user;
  }

  //Store User Data in firestore

  Future<void> storeUserDataInFirestore(User user) async {
    try {
      String? username = user.displayName;
      String? email = user.email;
      String? picture = user.photoURL;

      DocumentReference store =
          firestore.collection(usercollection).doc(currentuser!.uid);
      await store.set({
        'id': currentuser?.uid,
        'name': username,
        'email': email,
        'picture Url': picture,
      });
      // ignore: empty_catches
    } catch (e) {
      print(e);
    }
  }
}
