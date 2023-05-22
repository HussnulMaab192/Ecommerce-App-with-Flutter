import 'package:flutter/services.dart';
import 'package:flutter_amazon/models/category_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var subCat = [];
  var qty = 0.obs;
  var colorIndex = 0.obs;
  var totalPrice = 0.obs;

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
}
