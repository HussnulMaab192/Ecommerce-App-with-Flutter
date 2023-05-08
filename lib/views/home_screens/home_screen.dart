import 'package:flutter_amazon/consts/consts.dart';
import 'package:flutter_amazon/views/home_screens/components/feature_button.dart';
import 'package:get/get.dart';

import '../../lists.dart';
import '../../widgets_common/home_button.dart';
import '../../widgets_common/responsive_height.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: lightGrey,
      height: context.screenHeight,
      width: context.screenWidth,
      child: SafeArea(
          child: Column(
        children: [
          Container(
            height: context.height * 0.09,
            alignment: Alignment.center,
            color: lightGrey,
            child: TextFormField(
              decoration: const InputDecoration(
                filled: true,
                border: InputBorder.none,
                fillColor: whiteColor,
                hintText: searchAnything,
                suffixIcon: Icon(
                  Icons.search,
                  color: textfieldGrey,
                ),
                hintStyle: TextStyle(color: textfieldGrey),
              ),
            ),
          ),
          // swipper
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  VxSwiper.builder(
                    aspectRatio: 16 / 9,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    height: 150,
                    itemCount: sliderList.length,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        sliderList[index],
                        fit: BoxFit.fill,
                      )
                          .box
                          .rounded
                          .clip(Clip.antiAlias)
                          .margin(const EdgeInsets.symmetric(horizontal: 8))
                          .make();
                    },
                  ),
                  myCommonheight(0.015),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      2,
                      (index) => homeButton(
                        height: context.screenHeight * 0.14,
                        width: context.screenWidth / 2.2,
                        icon: index == 0 ? icTodaysDeal : icFlashDeal,
                        title: index == 0 ? todayDeal : flashSale,
                      ),
                    ),
                  ),
                  myCommonheight(0.015),
                  VxSwiper.builder(
                    aspectRatio: 16 / 9,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    height: 150,
                    itemCount: secondSliderList.length,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        secondSliderList[index],
                        fit: BoxFit.fill,
                      )
                          .box
                          .rounded
                          .clip(Clip.antiAlias)
                          .margin(const EdgeInsets.symmetric(horizontal: 8))
                          .make();
                    },
                  ),
                  myCommonheight(0.015),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      3,
                      (index) => homeButton(
                        height: context.screenHeight * 0.13,
                        width: context.screenWidth / 3.3,
                        icon: index == 0
                            ? icTopCategories
                            : index == 1
                                ? icBrands
                                : icTopSeller,
                        title: index == 0
                            ? topCategories
                            : index == 1
                                ? brands
                                : topSellers,
                      ),
                    ),
                  ),
                  myCommonheight(0.015),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: featuredCategories.text
                        .color(darkFontGrey)
                        .fontFamily(semibold)
                        .size(18)
                        .make(),
                  ).paddingOnly(left: 10),
                  myCommonheight(0.015),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                          3,
                          (index) => Column(
                                children: [
                                  featureButton(
                                    icon: featuredImages1[index],
                                    title: featuredList1[index],
                                  ),
                                  myCommonheight(0.01),
                                  featureButton(
                                    icon: featuredImages2[index],
                                    title: featuredList2[index],
                                  ),
                                ],
                              )),
                    ),
                  ),
                  myCommonheight(0.02),
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    decoration: const BoxDecoration(color: redColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        featureProduct.text
                            .size(18)
                            .fontFamily(bold)
                            .white
                            .make(),
                        myCommonheight(0.01),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                                6,
                                (index) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                  myCommonheight(0.02),
                  VxSwiper.builder(
                    aspectRatio: 16 / 9,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    height: 150,
                    itemCount: secondSliderList.length,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        secondSliderList[index],
                        fit: BoxFit.fill,
                      )
                          .box
                          .rounded
                          .clip(Clip.antiAlias)
                          .margin(const EdgeInsets.symmetric(horizontal: 8))
                          .make();
                    },
                  ),
                  // All products
                  myCommonheight(0.02),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 6,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 1,
                      mainAxisExtent: 300,
                    ),
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            imgP5,
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                          const Spacer(),
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
                          .color(whiteColor)
                          .roundedSM
                          .padding(const EdgeInsets.all(12))
                          .make();
                    },
                  ),
                  myCommonheight(0.015)
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
