import 'package:flutter/services.dart';
import 'package:flutter_amazon/consts/consts.dart';
import 'package:flutter_amazon/widgets_common/custom_button.dart';
import 'package:flutter_amazon/widgets_common/responsive_height.dart';

Widget exitDialouge(context) {
  return Dialog(
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      "confirm".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
      const Divider(),
      10.heightBox,
      "Are you sure you want to Exit?".text.size(18).color(darkFontGrey).make(),
      myCommonheight(0.01),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          customButton(
            buttonColor: redColor,
            textcolor: whiteColor,
            title: "Yes",
            onPressed: () {
              SystemNavigator.pop();
            },
          ),
          customButton(
            buttonColor: redColor,
            textcolor: whiteColor,
            title: "No",
            onPressed: () async {
              Navigator.pop(context);
            },
          )
        ],
      )
    ]).box.color(lightGrey).padding(const EdgeInsets.all(12)).rounded.make(),
  );
}
