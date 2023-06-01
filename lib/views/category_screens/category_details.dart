// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_amazon/consts/consts.dart';
import 'package:flutter_amazon/views/category_screens/items_details.dart';
import 'package:flutter_amazon/widgets_common/bg_widget.dart';
import 'package:get/get.dart';

import '../../controllers/product_controller.dart';
import '../../services/firestore.dart';
import '../../widgets_common/responsive_height.dart';

class CategoriesDetails extends StatelessWidget {
  String title;
  CategoriesDetails({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return bgWidget(
      Scaffold(
          appBar: AppBar(
            title: title.text.fontFamily(bold).white.make(),
          ),
          body: StreamBuilder(
              stream: FirestoreServices.getProduct(title),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    ),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                      child: Text(
                    'No user data available.',
                    style: TextStyle(
                        color: redColor, fontFamily: bold, fontSize: 28),
                  ));
                } else {
                  var data = snapshot.data!.docs;

                  return Container(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                                controller.subCat.length,
                                (index) => "${controller.subCat[index]}"
                                    .text
                                    .size(12)
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .makeCentered()
                                    .box
                                    .rounded
                                    .white
                                    .size(120, 60)
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 4))
                                    .make()),
                          ),
                        ),
                        myCommonheight(0.015),
                        Expanded(
                            child: GridView.builder(
                          itemCount: data.length,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8,
                                  crossAxisCount: 2,
                                  mainAxisExtent: 250),
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  data[index]['p_imgs'][0],
                                  width: 200,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                                10.heightBox,
                                "${data[index]['p_name']} "
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                myCommonheight(0.01),
                                "${data[index]['p_price']} "
                                    .numCurrency
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
                              controller.chekWishList(data[index]);
                              Get.to(ItemDetails(
                                data: data[index],
                                title: "${data[index]['p_name']} ",
                              ));
                            });
                          },
                        ))
                      ],
                    ),
                  );
                }
              })),
    );
  }
}
