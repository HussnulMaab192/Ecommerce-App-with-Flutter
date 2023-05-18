import 'package:flutter_amazon/consts/consts.dart';

Widget cartDetailsButton({width, String? count, String? title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.fontFamily(bold).size(16).color(darkFontGrey).make(),
      title!.text.fontFamily(bold).color(darkFontGrey).make(),
    ],
  )
      .box
      .white
      .rounded
      .width(width)
      .height(60)
      .padding(const EdgeInsets.only(
        left: 4,
        right: 4,
      ))
      .make();
}
