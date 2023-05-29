import 'package:flutter_amazon/consts/consts.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    getUsername();
  }

  RxInt navIndex = 0.obs;
  var userName = '';
  getUsername() async {
    var n = await firestore
        .collection(usersCollection)
        .where('uid', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });
    userName = n;
  }
}
