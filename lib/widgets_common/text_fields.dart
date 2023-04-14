import 'package:flutter_amazon/consts/consts.dart';
import 'package:flutter_amazon/widgets_common/responsive_height.dart';

Widget customTextField({
  String? hint,
  String? title,
  controller,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(redColor).fontFamily(semibold).size(16).make(),
      myCommonheight(0.01),
      TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintStyle:
              const TextStyle(fontFamily: semibold, color: textfieldGrey),
          hintText: hint!,
          isDense: true,
          fillColor: lightGrey,
          filled: true,
          border: InputBorder.none,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: redColor),
          ),
        ),
      )
    ],
  );
}
