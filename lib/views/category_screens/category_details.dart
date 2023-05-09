// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_amazon/consts/consts.dart';
import 'package:flutter_amazon/views/category_screens/items_details.dart';
import 'package:flutter_amazon/widgets_common/bg_widget.dart';
import 'package:get/get.dart';

import '../../widgets_common/responsive_height.dart';

class CategoriesDetails extends StatelessWidget {
  String title;
  CategoriesDetails({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      Scaffold(
        appBar: AppBar(
          title: title.text.fontFamily(bold).white.make(),
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                      6,
                      (index) => "Baby Clothing"
                          .text
                          .size(12)
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .makeCentered()
                          .box
                          .rounded
                          .white
                          .size(120, 60)
                          .margin(const EdgeInsets.symmetric(horizontal: 4))
                          .make()),
                ),
              ),
              myCommonheight(0.015),
              Expanded(
                  child: GridView.builder(
                itemCount: 6,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    crossAxisCount: 2,
                    mainAxisExtent: 250),
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        imgP5,
                        width: 200,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                      "Shopping Bag "
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                      myCommonheight(0.01),
                      "\$500"
                          .text
                          .color(redColor)
                          .size(16)
                          .fontFamily(bold)
                          .make(),
                    ],
                  )
                      .box
                      .color(whiteColor)
                      .roundedSM
                      .outerShadow
                      .padding(const EdgeInsets.all(12))
                      .make()
                      .onTap(() {
                    Get.to(ItemDetails(
                      title: "Dummy Item",
                    ));
                  });
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
