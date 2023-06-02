import 'package:flutter_amazon/consts/consts.dart';

Widget orderStatus(icon, color, title, showDone) {
  return ListTile(
    leading: Icon(
      icon,
      color: color,
    ).box.border(color: color).make(),
    trailing: SizedBox(
      height: 100,
      width: 120,
      child: Row(
        children: [
          "$title".text.color(darkFontGrey).make(),
          showDone
              ? const Icon(
                  Icons.done_all_rounded,
                  color: redColor,
                )
              : Container(),
        ],
      ),
    ),
  );
}
