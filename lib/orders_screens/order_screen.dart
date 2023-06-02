import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_amazon/consts/consts.dart';
import 'package:flutter_amazon/orders_screens/orders_details.dart';
import 'package:get/get.dart';

import '../services/firestore.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: whiteColor,
          automaticallyImplyLeading: false,
          title:
              "My Orders".text.color(darkFontGrey).fontFamily(semibold).make(),
        ),
        body: StreamBuilder(
            stream: FirestoreServices.getAllOrders(),
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
                  'No orders Yet',
                  style: TextStyle(
                      color: redColor, fontFamily: bold, fontSize: 28),
                ));
              } else {
                var data = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: "${index + 1}"
                          .text
                          .fontFamily(bold)
                          .color(redColor)
                          .make(),
                      title: data[index]['order_code']
                          .toString()
                          .text
                          .color(redColor)
                          .fontFamily(semibold)
                          .make(),
                      subtitle: data[index]['total_amount']
                          .toString()
                          .numCurrency
                          .text
                          .fontFamily(bold)
                          .make(),
                      trailing: IconButton(
                        onPressed: () {
                          Get.to(() => OrdersDetails(
                                data: data[index],
                              ));
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: darkFontGrey,
                        ),
                      ),
                    );
                  },
                );
              }
            }));
  }
}
