import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_amazon/consts/consts.dart';
import 'package:flutter_amazon/views/auth_screens/login_screen.dart';
import 'package:flutter_amazon/views/home_screens/home.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  bool isLoader = false;
  bool isButtonDisabled = false;

  Future handleForgotPassword({required email}) async {
    if (isButtonDisabled) {
      return; // Prevent multiple clicks while button is disabled
    }

    isButtonDisabled = true;

    update();

    await forgotPassword(email: email);

    // Delay for 10 seconds

    isButtonDisabled = false;
    update();
  }

  updateLoder() {
    isLoader = !isLoader;
    update();
  }

  Future<UserCredential?> loginMethod(
      {required String email, required String password, context}) async {
    UserCredential? userCredential;
    updateLoder();
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (!auth.currentUser!.emailVerified) {
        await sendVerification(context);
      } else {
        Get.offAll(() => const Home());
      }
      updateLoder();
    } on FirebaseAuthException catch (err) {
      updateLoder();
      Get.snackbar("Error", err.toString(), colorText: whiteColor);
    }
    return userCredential;
  }

  Future<UserCredential?> signUpMethod({
    required String email,
    required String password,
    context,
    required String name,
  }) async {
    UserCredential? userCredential;
    updateLoder();
    print("in the signup Method *****************");
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await storeUserData(
          name: name,
          email: email,
          context: context,
          password: password,
          uid: auth.currentUser!.uid);

      await sendVerification(context);
      updateLoder();
    } on FirebaseAuthException catch (err) {
      updateLoder();
      Get.snackbar("Error", "$err", colorText: whiteColor);
    }

    return userCredential;
  }

// storing data method

  storeUserData({
    required name,
    required String uid,
    required email,
    required password,
    context,
  }) {
    try {
      DocumentReference store = firestore.collection(usersCollection).doc(uid);
      store.set({
        'name': name,
        'password': password,
        'email': email,
        'imageUrl': "",
        "uid": uid,
        "cart_count": "00",
        "order_count": "00",
        "whishList_count": "00",
      });
    } on FirebaseAuthException catch (err) {
      VxToast.show(context, msg: err.toString());
    }
  }

  // Email Verification
  Future sendVerification(
    BuildContext context,
  ) async {
    try {
      auth.currentUser!.sendEmailVerification();
      Get.snackbar("Confirm Email", "Confirm Your Email and Login Again.");
      Get.offAll(() => const LoginScreen());
    } on FirebaseException catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

// forgot password
  Future forgotPassword({required String email}) async {
    updateLoder();
    try {
      await auth.sendPasswordResetEmail(email: email);
      Get.snackbar("Message", "Please check your email ");
      updateLoder();
    } on FirebaseException catch (e) {
      Get.snackbar("Error", e.message!);
      updateLoder();
    }
  }

  signOut({required context}) async {
    try {
      await auth.signOut();
      print("its been signedOut");
      Get.offAll(() => const LoginScreen());
    } on FirebaseException catch (e) {
      Get.snackbar("Error!", e.toString());
    }
  }
}
