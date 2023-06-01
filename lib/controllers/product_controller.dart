import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_amazon/consts/consts.dart';
import 'package:flutter_amazon/models/category_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var subCat = [];
  var qty = 0.obs;
  var colorIndex = 0.obs;
  var totalPrice = 0.obs;
  var isFav = false.obs;

  calculateTotalPrice(price) {
    totalPrice.value = price * qty.value;
  }

  changeColorIndex(index) {
    colorIndex = index;
  }

  increaseQuantity({required totalQty}) {
    if (qty.value < totalQty) {
      qty.value++;
    }
  }

  decreaseQuantity() {
    qty.value--;
  }

  getSubCategories(title) async {
    subCat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");

    var decoded = categoryModelFromJson(data);

    var s =
        decoded.categories.where((element) => element.name == title).toList();

    for (var e in s[0].subcategory) {
      subCat.add(e);
    }
  }

  addToCart({
    required title,
    required img,
    required sellername,
    required clor,
    required qty,
    required tPrice,
    required vendorId,
  }) async {
    await firestore.collection(cartCollection).doc().set({
      'title': title,
      'img': img,
      'sellername': sellername,
      'color': clor,
      'qty': qty,
      'vendor_id': vendorId,
      'tPrice': tPrice,
      'added_by': currentUser!.uid,
    }).catchError((error) {
      Get.snackbar("Error!", error.toString());
    });
  }

  addToWishList(docId) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_whishList': FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(true);
    Get.snackbar("Message", "Added to wish List", colorText: redColor);
  }

  removeFromWishList(docId) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_whishList': FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(false);
    Get.snackbar("Message", "remove from wish List", colorText: redColor);
  }

  chekWishList(data) async {
    if (data['p_whishList'].contains(currentUser!.uid)) {
      isFav(true);
    } else {
      isFav(false);
    }
  }
}
