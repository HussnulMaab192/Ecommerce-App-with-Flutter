import 'package:flutter_amazon/consts/consts.dart';
import 'package:flutter_amazon/controllers/authController.dart';
import 'package:flutter_amazon/lists.dart';
import 'package:flutter_amazon/widgets_common/bg_widget.dart';
import 'package:flutter_amazon/widgets_common/responsive_height.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/cart_details_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var mycontroller = Get.put(AuthController());
    return bgWidget(Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          // Edit profile button
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: const Align(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.edit,
                  color: whiteColor,
                )).onTap(() {}),
          ),

          // user details section
          Padding(
            padding: const EdgeInsets.only(right: 8, left: 5),
            child: Row(
              children: [
                Image.asset(
                  imgProfile,
                  width: 90,
                  fit: BoxFit.cover,
                ).box.roundedFull.clip(Clip.antiAlias).make(),
                10.widthBox,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "Dummy User".text.fontFamily(semibold).white.make(),
                      myCommonheight(0.002),
                      "mabimalik192@gmail.com".text.white.make(),
                    ],
                  ),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: whiteColor)),
                  onPressed: () async {
                    await mycontroller.signOut(context: context);

                    // as i am checking the user from fire base so i dont have need of shared preferance.

                    // SharedPreferences prefs =
                    //     await SharedPreferences.getInstance();
                    // await prefs.setBool('isLoggedIn', false);
                    // print("value of isLoggedin is false");
                  },
                  child: "Log Out".text.fontFamily(semibold).white.make(),
                )
              ],
            ),
          ),
          myCommonheight(0.02),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                cartDetailsButton(
                    width: context.screenWidth / 3.3,
                    count: "00 ",
                    title: "In your cart "),
                6.widthBox,
                cartDetailsButton(
                    width: context.screenWidth / 3.3,
                    count: "32 ",
                    title: "your Wish List "),
                6.widthBox,
                cartDetailsButton(
                    width: context.screenWidth / 3.3,
                    count: "67 ",
                    title: "Your Orders "),
              ],
            ),

            // Buttons Sections
          ),

          ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Image.asset(
                        profileButtonIcons[index],
                        width: 22,
                      ),
                      title: profileButtonItoms[index]
                          .text
                          .fontFamily(searchAnything)
                          .color(darkFontGrey)
                          .make(),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: lightGrey,
                    );
                  },
                  itemCount: profileButtonItoms.length)
              .box
              .white
              .padding(const EdgeInsets.symmetric(horizontal: 16))
              .rounded
              .margin(const EdgeInsets.all(12))
              .shadowSm
              .make()
              .box
              .color(redColor)
              .make()
        ],
      )),
    ));
  }
}
