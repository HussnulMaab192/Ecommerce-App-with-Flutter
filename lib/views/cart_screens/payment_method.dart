import 'package:flutter_amazon/consts/consts.dart';
import 'package:flutter_amazon/controllers/cartController.dart';
import 'package:flutter_amazon/lists.dart';
import 'package:flutter_amazon/views/home_screens/home.dart';
import 'package:get/get.dart';

import '../../widgets_common/custom_button.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: "Choose Payment Method"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 50,
        child: controller.placingOrder.value == true
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              )
            : customButton(
                onPressed: () async {
                  await controller.placeMyOrder(
                      orderPaymentMethod:
                          paymentMethod[controller.paymentIndex.value],
                      totalAmount: controller.totoalP.value);

                  await controller.clearCart();
                  Get.snackbar('Message', "Order Placed Successfully");
                  Get.offAll(() => const Home());
                },
                buttonColor: redColor,
                textcolor: whiteColor,
                title: "Place Order"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Obx(
          () => Column(
            children: List.generate(paymentMethodImg.length, (index) {
              return GestureDetector(
                onTap: () {
                  controller.changePaymentIndex(index);
                },
                child: Container(
                    clipBehavior: Clip.antiAlias,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: controller.paymentIndex.value == index
                              ? redColor
                              : Colors.transparent,
                          width: 4,
                          style: BorderStyle.solid),
                    ),
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image.asset(
                          paymentMethodImg[index],
                          width: double.infinity,
                          height: 120,
                          fit: BoxFit.cover,
                          colorBlendMode: controller.paymentIndex.value == index
                              ? BlendMode.darken
                              : BlendMode.color,
                          color: controller.paymentIndex.value == index
                              ? Colors.black.withOpacity(0.4)
                              : Colors.transparent,
                        ),
                        controller.paymentIndex.value == index
                            ? Transform.scale(
                                scale: 1.3,
                                child: Checkbox(
                                  activeColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  value: true,
                                  onChanged: (value) {},
                                ),
                              )
                            : Container(),
                        Positioned(
                            bottom: 0,
                            right: 10,
                            child: paymentMethod[index]
                                .text
                                .white
                                .fontFamily(bold)
                                .make())
                      ],
                    )),
              );
            }),
          ),
        ),
      ),
    );
  }
}
