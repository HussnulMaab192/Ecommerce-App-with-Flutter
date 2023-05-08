import 'package:flutter_amazon/consts/consts.dart';
import 'package:flutter_amazon/widgets_common/responsive_height.dart';

Widget homeButton({width, height, String? title, icon, onPress}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        icon,
        width: 26,
      ),
      myCommonheight(0.005),
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  ).box.rounded.white.size(width, height).shadowSm.make();
}
