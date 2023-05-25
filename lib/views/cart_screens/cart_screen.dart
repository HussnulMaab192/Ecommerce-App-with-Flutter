import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_amazon/consts/consts.dart';
import 'package:flutter_amazon/widgets_common/custom_button.dart';
import 'package:flutter_amazon/widgets_common/responsive_height.dart';
import 'package:get/get.dart';

import '../../controllers/cartController.dart';
import '../../services/firestore.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: whiteColor,
          automaticallyImplyLeading: false,
          title: "Shopping Cart"
              .text
              .color(darkFontGrey)
              .fontFamily(semibold)
              .make(),
        ),
        body: StreamBuilder(
            stream: FirestoreServices.getCart(currentUser!.uid),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  ),
                );
              }

              if (snapshot.data!.docs.isEmpty) {
                return const Center(
                    child: Text(
                  'Cart is Empty',
                  style: TextStyle(
                      color: redColor, fontFamily: bold, fontSize: 28),
                ));
              }
              if (!snapshot.hasData) {
                return const Center(
                    child: Text(
                  'No user data is available',
                  style: TextStyle(
                      color: redColor, fontFamily: bold, fontSize: 28),
                ));
              } else {
                var data = snapshot.data!.docs;
                controller.calculate(data);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                          child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              radius:
                                  30, // Adjust the radius as per your requirement
                              backgroundImage:
                                  NetworkImage("${data[index]['img']}"),
                            ),
                            title:
                                "${data[index]['title']} (x${data[index]['qty']})"
                                    .text
                                    .fontFamily(semibold)
                                    .size(16)
                                    .make(),
                            subtitle: "${data[index]['tPrice']}"
                                .numCurrency
                                .text
                                .color(redColor)
                                .fontFamily(semibold)
                                .size(14)
                                .make(),
                            trailing: const Icon(
                              Icons.delete,
                              color: redColor,
                            ).onTap(() async {
                              await FirestoreServices.deletDocument(
                                  data[index].id);
                            }),
                          );
                        },
                      )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "Total Price"
                              .text
                              .color(darkFontGrey)
                              .fontFamily(semibold)
                              .make(),
                          Obx(
                            () => "${controller.totoalP}"
                                .numCurrency
                                .text
                                .color(redColor)
                                .fontFamily(semibold)
                                .make(),
                          ),
                        ],
                      )
                          .box
                          .padding(const EdgeInsets.all(12))
                          .color(const Color(0xffFF7F50))
                          .width(context.screenWidth - 60)
                          .roundedSM
                          .make(),
                      myCommonheight(0.01),
                      SizedBox(
                        width: context.screenWidth - 60,
                        child: customButton(
                            onPressed: () {},
                            buttonColor: redColor,
                            textcolor: whiteColor,
                            title: "Proceed To Shipping"),
                      )
                    ],
                  ),
                );
              }
            }));
  }
}
