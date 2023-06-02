import 'package:flutter_amazon/consts/consts.dart';
import 'package:flutter_amazon/orders_screens/components/order_status.dart';

class OrdersDetails extends StatelessWidget {
  final dynamic data;
  const OrdersDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Order Details".text.fontFamily(semibold).make(),
      ),
      body: Column(
        children: [
          Column(
            children: [
              orderStatus(
                  Icons.done, redColor, "Order Placed", data['order_placed']),
              orderStatus(
                  Icons.done, redColor, "Confirm", data['order_confirmed']),
              orderStatus(
                  Icons.done, redColor, "Delivery", data['order_on_delivery']),
              orderStatus(
                  Icons.done, redColor, "Delivered", data['order_delivered'])
            ],
          )
        ],
      ),
    );
  }
}
