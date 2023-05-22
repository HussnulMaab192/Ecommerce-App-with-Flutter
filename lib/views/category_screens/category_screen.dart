import 'package:flutter_amazon/consts/consts.dart';
import 'package:flutter_amazon/controllers/product_controller.dart';
import 'package:flutter_amazon/lists.dart';
import 'package:flutter_amazon/views/category_screens/category_details.dart';
import 'package:flutter_amazon/widgets_common/bg_widget.dart';
import 'package:flutter_amazon/widgets_common/responsive_height.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return bgWidget(Scaffold(
      appBar: AppBar(title: category.text.white.fontFamily(bold).make()),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: 9,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 200,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              crossAxisCount: 3),
          itemBuilder: (context, index) {
            return Column(
              children: [
                Image.asset(
                  categoriesImages[index],
                  height: 120,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                myCommonheight(0.01),
                categoriesList[index]
                    .text
                    .align(TextAlign.center)
                    .color(darkFontGrey)
                    .make()
              ],
            )
                .box
                .white
                .rounded
                .clip(Clip.antiAlias)
                .outerShadowSm
                .make()
                .onTap(() {
              controller.getSubCategories(categoriesList[index]);
              print("the title here is :${categoriesList[index]}");
              Get.to(CategoriesDetails(title: categoriesList[index]));
            });
          },
        ),
      ),
    ));
  }
}
