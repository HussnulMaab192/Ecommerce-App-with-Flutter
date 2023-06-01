import 'package:flutter_amazon/consts/consts.dart';
import 'package:flutter_amazon/controllers/cartController.dart';
import 'package:flutter_amazon/views/cart_screens/payment_method.dart';
import 'package:flutter_amazon/widgets_common/custom_button.dart';
import 'package:flutter_amazon/widgets_common/text_fields.dart';
import 'package:get/get.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: "Shipping Info"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 50,
        child: customButton(
            onPressed: () async {
              if (controller.addressController.text.isNotEmpty ||
                  controller.cityController.text.isNotEmpty ||
                  controller.postalCodeController.text.isNotEmpty ||
                  controller.phoneController.text.isNotEmpty) {
                Get.to(() => const PaymentMethod());
              } else {
                Get.snackbar("Message", "Please fill all fields");
              }
            },
            buttonColor: redColor,
            textcolor: whiteColor,
            title: "Continue"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            customTextField(
                hint: "Address",
                ispass: false,
                title: "Adress",
                controller: controller.addressController),
            customTextField(
                hint: "City",
                ispass: false,
                title: "City",
                controller: controller.cityController),
            customTextField(
                hint: "State",
                ispass: false,
                title: "State",
                controller: controller.stateController),
            customTextField(
                hint: "Postal Code",
                ispass: false,
                title: "Postal Code",
                controller: controller.postalCodeController),
            customTextField(
                hint: "Phone",
                ispass: false,
                title: "Phone",
                controller: controller.phoneController),
          ],
        ),
      ),
    );
  }
}
