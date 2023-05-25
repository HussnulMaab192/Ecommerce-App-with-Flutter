import 'package:get/get.dart';

class CartController extends GetxController {
  var totoalP = 0.obs;
  calculate(data) {
    totoalP.value = 0;
    for (var i = 0; i < data.length; i++) {
      totoalP = totoalP + int.parse(data[i]['tPrice'].toString());
    }
  }
}
