import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_amazon/consts/consts.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  RxString profilePic = "".obs;
  var profileImageLink = " ";
  var isLoading = false.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  changeProfilePic() async {
    try {
      final picker = ImagePicker();
      final pickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        profilePic.value = pickedImage.path;
      } else {
        return;
      }
    } on PlatformException catch (e) {
      Get.snackbar("Message", e.toString());
    }
  }

  uplodProfileImage() async {
    var filename = basename(profilePic.value);
    var destination = 'images/${currentUser!.uid}/$filename';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profilePic.value));
    profileImageLink = await ref.getDownloadURL();
  }

  updateProfile(name, password, imageUrl) async {
    var store = firestore.collection(usersCollection).doc(currentUser!.uid);

    await store.update({
      'name': name,
      'password': password,
      'imageUrl': imageUrl,
    });
    isLoading(false);
  }

  changeAuthPassword(email, password, newPassword) async {
    final cred = EmailAuthProvider.credential(email: email, password: password);
    await currentUser!.reauthenticateWithCredential(cred).then((value) {
      currentUser!.updatePassword(newPassword);
    }).catchError((error) {
      Get.snackbar("Error", error.toString());
    });
  }
}
