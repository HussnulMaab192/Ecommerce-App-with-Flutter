import 'package:flutter_amazon/consts/consts.dart';

Widget customButton({
  required void Function()? onPressed,
  Color? textcolor,
  String? title,
  Color? buttonColor,
}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor, padding: const EdgeInsets.all(12)),
      onPressed: onPressed,
      child: title!.text.color(textcolor).fontFamily(bold).make());
}
