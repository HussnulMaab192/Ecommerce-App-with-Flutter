import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_amazon/consts/consts.dart';
import '../../../widgets_common/responsive_height.dart';
import 'package:intl/intl.dart' as intl;

Widget senderBubble(DocumentSnapshot data) {
  var t =
      data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();
  var time = intl.DateFormat("h:mma").format(t);
  print("time is :$time");
  return Container(
    padding: const EdgeInsets.all(12),
    margin: const EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
        color: data['uId'] == currentUser!.uid ? redColor : Colors.green,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        )),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "${data["_msg"]}".text.white.size(16).make(),
        myCommonheight(0.01),
        time.text.color(whiteColor.withOpacity(0.5)).make(),
      ],
    ),
  );
}
