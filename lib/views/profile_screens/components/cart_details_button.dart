import 'package:flutter_amazon/consts/consts.dart';

import '../../../widgets_common/responsive_height.dart';

Widget cartDetailsButton({width, String? count, String? title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.fontFamily(bold).size(16).color(darkFontGrey).make(),
      myCommonheight(0.005),
      title!.text.fontFamily(bold).color(darkFontGrey).make(),
    ],
  )
      .box
      .white
      .rounded
      .width(width)
      .height(70)
      .padding(const EdgeInsets.all(4))
      .make();
}
