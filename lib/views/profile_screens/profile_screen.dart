import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_amazon/consts/consts.dart';
import 'package:flutter_amazon/controllers/authController.dart';
import 'package:flutter_amazon/lists.dart';
import 'package:flutter_amazon/views/profile_screens/edit_profile.dart';
import 'package:flutter_amazon/widgets_common/bg_widget.dart';
import 'package:flutter_amazon/widgets_common/responsive_height.dart';
import 'package:get/get.dart';

import '../../controllers/profile_controller.dart';
import '../../services/firestore.dart';
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
    var controller = Get.put(ProfileController());

    return bgWidget(Scaffold(
      body: StreamBuilder(
        stream: FirestoreServices.getUser(currentUser!.uid),
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
              style: TextStyle(color: redColor, fontFamily: bold, fontSize: 28),
            ));
          } else {
            var data = snapshot.data!.docs[0];
            return SafeArea(
                child: Column(
              children: [
                // Edit profile button
                Padding(
                  padding: const EdgeInsets.only(top: 5, right: 8),
                  child: const Align(
                      alignment: Alignment.topRight,
                      child: Icon(
                        Icons.edit,
                        color: whiteColor,
                      )).onTap(() async {
                    controller.nameController.text = data['name'];

                    await Get.to(() => EditProfile(
                          data: data,
                        ));
                  }),
                ),

                // user details section
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.13,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8, left: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        data['imageUrl'] == ''
                            ? Image.asset(
                                imgProfile,
                                width: 90,
                                fit: BoxFit.cover,
                              ).box.roundedFull.clip(Clip.antiAlias).make()
                            : Image.network(
                                data['imageUrl'],
                                width: 80,
                                fit: BoxFit.cover,
                              ).box.roundedFull.clip(Clip.antiAlias).make(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            "${data['name']}"
                                .text
                                .fontFamily(semibold)
                                .white
                                .make(),
                            myCommonheight(0.002),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Text(
                                  "${data['email']}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: semibold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ))
                          ],
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
                          child:
                              "Log Out".text.fontFamily(semibold).white.make(),
                        )
                      ],
                    ),
                  ),
                ),

                MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        cartDetailsButton(
                            width: context.screenWidth / 3.3,
                            count: data['cart_count'],
                            title: "In your cart "),
                        6.widthBox,
                        cartDetailsButton(
                            width: context.screenWidth / 3.3,
                            count: data['whishList_count'],
                            title: "your Wish List "),
                        6.widthBox,
                        cartDetailsButton(
                            width: context.screenWidth / 3.3,
                            count: data['order_count'],
                            title: "Your Orders"),
                      ],
                    ),

                    // Buttons Sections
                  ),
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
            ));
          }
        },
      ),
    ));
  }
}
