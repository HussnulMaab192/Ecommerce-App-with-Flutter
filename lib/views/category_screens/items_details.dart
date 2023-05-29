// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_amazon/consts/consts.dart';
import 'package:flutter_amazon/controllers/product_controller.dart';
import 'package:flutter_amazon/lists.dart';
import 'package:flutter_amazon/widgets_common/custom_button.dart';
import 'package:flutter_amazon/widgets_common/responsive_height.dart';
import 'package:get/get.dart';

import '../chat_screen/chat_screen.dart';

class ItemDetails extends StatelessWidget {
  String title;
  final dynamic data;
  ItemDetails({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controler = Get.find<ProductController>();
    controler.calculateTotalPrice(int.parse(data['p_price']));
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        shadowColor: whiteColor,
        title: title.text.color(darkFontGrey).fontFamily(bold).make(),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.share,
              )),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_border_outlined,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VxSwiper.builder(
                      autoPlay: true,
                      height: 350,
                      aspectRatio: 16 / 9,
                      itemCount: data['p_imgs'].length,
                      viewportFraction: 0.8,
                      itemBuilder: (context, index) {
                        return Image.network(
                          data['p_imgs'][index],
                          width: double.infinity,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                    myCommonheight(0.01),
                    title.text
                        .size(16)
                        .color(darkFontGrey)
                        .fontFamily(bold)
                        .make(),
                    myCommonheight(0.01),
                    VxRating(
                      value: double.parse(data['p_rating']),
                      onRatingUpdate: (value) {},
                      normalColor: textfieldGrey,
                      selectionColor: golden,
                      count: 5,
                      size: 25,
                      stepInt: true,
                    ),
                    myCommonheight(0.01),
                    double.parse(data['p_price'])
                        .numCurrency
                        .text
                        .color(redColor)
                        .fontFamily(bold)
                        .size(18)
                        .make(),
                    myCommonheight(0.01),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Seller"
                                  .text
                                  .white
                                  .size(16)
                                  .fontFamily(bold)
                                  .make(),
                              myCommonheight(0.005),
                              "${data['p_seller']}"
                                  .text
                                  .color(darkFontGrey)
                                  .semiBold
                                  .make(),
                            ],
                          ),
                        ),
                        const CircleAvatar(
                          backgroundColor: whiteColor,
                          child: Icon(Icons.message_outlined),
                        ).onTap(() {
                          Get.to(() => const ChatScreen(),
                              arguments: [data['p_seller'], data['vendor_id']]);
                        }),
                      ],
                    )
                        .box
                        .height(70)
                        .roundedSM
                        .color(textfieldGrey)
                        .padding(const EdgeInsets.symmetric(horizontal: 16))
                        .make(),
                    myCommonheight(0.02),
                    Obx(
                      () => Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child:
                                    "Color: ".text.color(textfieldGrey).make(),
                              ),
                              Row(
                                children: List.generate(
                                    data['p_colors'].length,
                                    (index) => Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            VxBox()
                                                .size(40, 40)
                                                .roundedFull
                                                .color(Color(
                                                        data['p_colors'][index])
                                                    .withOpacity(1.0))
                                                .margin(
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 6))
                                                .make()
                                                .onTap(() {
                                              controler.colorIndex(index);
                                            }),
                                            Visibility(
                                              visible: index ==
                                                  controler.colorIndex.value,
                                              child: const Icon(
                                                Icons.done,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        )),
                              )
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),

                          // quantity row

                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Quantity: "
                                    .text
                                    .color(textfieldGrey)
                                    .make(),
                              ),
                              Obx(
                                () => Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        if (controler.qty > 0) {
                                          controler.decreaseQuantity();
                                          controler.calculateTotalPrice(
                                              int.parse(data['p_price']));
                                        }
                                      },
                                      iconSize: 28,
                                      icon: const Icon(Icons.remove),
                                    ),
                                    SizedBox(
                                      width: 40,
                                      child: Text(
                                        controler.qty.value.toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 22,
                                            color: darkFontGrey,
                                            fontFamily: bold),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        controler.increaseQuantity(
                                            totalQty:
                                                int.parse(data["p_quantity"]));

                                        controler.calculateTotalPrice(
                                            int.parse(data['p_price']));
                                      },
                                      iconSize: 28,
                                      icon: const Icon(Icons.add),
                                    ),
                                    SizedBox(
                                      width: 80,
                                      child: "(${data['p_quantity']} available)"
                                          .text
                                          .size(12)
                                          .color(textfieldGrey)
                                          .fontFamily(bold)
                                          .make(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child:
                                    "Total: ".text.color(textfieldGrey).make(),
                              ),
                              controler.totalPrice.value
                                  .toString()
                                  .numCurrency
                                  .text
                                  .size(16)
                                  .color(redColor)
                                  .fontFamily(bold)
                                  .make(),
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),
                        ],
                      ).box.white.shadowSm.make(),
                    ),
                    // Description section is here
                    myCommonheight(0.01),
                    "Description"
                        .text
                        .color(darkFontGrey)
                        .fontFamily(bold)
                        .make(),
                    myCommonheight(0.01),
                    " ${data['p_desc']} ".text.color(textfieldGrey).make(),
                    myCommonheight(0.01),

                    // Button sections

                    ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(
                        itemsButtonDeailsList.length,
                        (index) => Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: Colors.grey.shade300),
                          ),
                          child: ListTile(
                            title: itemsButtonDeailsList[index]
                                .text
                                .color(darkFontGrey)
                                .fontFamily(semibold)
                                .make(),
                            trailing: const Icon(Icons.arrow_forward),
                          ),
                        ),
                      ),
                    ),

                    //Product  you may Also like
                    myCommonheight(0.01),
                    productYouMayAlsoLike.text
                        .size(16)
                        .color(darkFontGrey)
                        .fontFamily(bold)
                        .make(),

                    myCommonheight(0.01),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            6,
                            (index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      imgP1,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                    myCommonheight(0.01),
                                    "Laptop 4GB /64GB "
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
                                    .white
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 4))
                                    .rounded
                                    .padding(const EdgeInsets.all(8))
                                    .make()),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: customButton(
                onPressed: () {
                  controler.addToCart(
                      clor: data["p_colors"][controler.colorIndex.value],
                      img: data["p_imgs"][0],
                      qty: controler.qty.value,
                      sellername: data["p_seller"],
                      title: data["p_name"],
                      tPrice: controler.totalPrice.value);
                  Get.snackbar("Message", "Added to Cart");
                },
                buttonColor: redColor,
                textcolor: whiteColor,
                title: "Add to Cart"),
          ),
        ],
      ),
    );
  }
}
