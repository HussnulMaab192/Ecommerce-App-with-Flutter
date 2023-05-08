import 'package:flutter_amazon/consts/consts.dart';
import 'package:flutter_amazon/widgets_common/responsive_height.dart';

Widget featureButton({String? title, icon}) {
  return Row(
    children: [
      Image.asset(
        icon,
        width: 60,
        fit: BoxFit.fill,
      ),
      myCommonheight(0.01),
      title!.text.fontFamily(semibold).size(18).color(darkFontGrey).make()
    ],
  )
      .box
      .width(200)
      .roundedSM
      .margin(const EdgeInsets.symmetric(horizontal: 4))
      .white
      .padding(const EdgeInsets.all(5))
      .make();
}
