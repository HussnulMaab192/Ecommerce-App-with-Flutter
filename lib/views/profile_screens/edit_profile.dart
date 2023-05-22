import 'dart:io';

import 'package:flutter_amazon/consts/consts.dart';
import 'package:flutter_amazon/controllers/profile_controller.dart';
import 'package:flutter_amazon/views/profile_screens/profile_screen.dart';
import 'package:flutter_amazon/widgets_common/bg_widget.dart';
import 'package:flutter_amazon/widgets_common/custom_button.dart';
import 'package:flutter_amazon/widgets_common/responsive_height.dart';
import 'package:flutter_amazon/widgets_common/text_fields.dart';
import 'package:get/get.dart';

class EditProfile extends StatelessWidget {
  final dynamic data;
  const EditProfile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    print(Colors.purple.value);
    var controller = Get.find<ProfileController>();

    return bgWidget(Scaffold(
      appBar: AppBar(
        title: const Text("Edit Your Profile"),
      ),
      body: Obx(
        () => SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              data['imageUrl'] == '' && controller.profilePic.isEmpty
                  ? Image.asset(imgProfile, width: 100, fit: BoxFit.cover)
                      .box
                      .roundedFull
                      .clip(Clip.antiAlias)
                      .make()
                  : data['imageUrl'] != '' && controller.profilePic.isEmpty
                      ? Image.network(data['imageUrl'],
                              width: 100, fit: BoxFit.cover)
                          .box
                          .roundedFull
                          .clip(Clip.antiAlias)
                          .make()
                      : Image.file(
                              File(
                                controller.profilePic.value,
                              ),
                              width: 100,
                              fit: BoxFit.cover)
                          .box
                          .roundedFull
                          .clip(Clip.antiAlias)
                          .make(),
              myCommonheight(0.01),
              customButton(
                onPressed: () async {
                  await controller.changeProfilePic();
                },
                buttonColor: redColor,
                textcolor: whiteColor,
                title: "Change",
              ),
              const Divider(),
              myCommonheight(0.02),
              customTextField(
                  controller: controller.nameController,
                  hint: nameHint,
                  title: name,
                  ispass: false),
              10.heightBox,
              customTextField(
                  controller: controller.oldPasswordController,
                  hint: passwordHint,
                  title: oldPassword,
                  ispass: true),
              10.heightBox,
              customTextField(
                  controller: controller.newPasswordController,
                  hint: passwordHint,
                  title: newPassword,
                  ispass: true),
              myCommonheight(0.02),
              controller.isLoading.value
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    )
                  : SizedBox(
                      width: context.screenWidth - 60,
                      child: customButton(
                        onPressed: () async {
                          controller.isLoading(true);
                          if (controller.profilePic.value.isNotEmpty) {
                            await controller.uplodProfileImage();
                          } else {
                            controller.profileImageLink = data['imageUrl'];
                          }

                          if (data['password'] ==
                              controller.oldPasswordController.text) {
                            await controller.changeAuthPassword(
                                data['email'],
                                data['password'],
                                controller.newPasswordController.text);

                            await controller.updateProfile(
                                controller.nameController.text,
                                controller.newPasswordController.text,
                                controller.profileImageLink);
                            controller.newPasswordController.clear();
                            controller.oldPasswordController.clear();

                            Get.snackbar(
                                "Message", "Profile Updated Successfully",
                                colorText: whiteColor);
                            Get.off(const ProfileScreen());
                          } else {
                            Get.snackbar(
                                "Alert!!", "Old Password is not Correct.",
                                colorText: whiteColor);
                            controller.isLoading(false);
                          }
                        },
                        buttonColor: redColor,
                        textcolor: whiteColor,
                        title: "Save",
                      ),
                    )
            ],
          )
              .box
              .white
              .shadowSm
              .padding(const EdgeInsets.all(16))
              .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
              .rounded
              .make(),
        ),
      ),
    ));
  }
}
