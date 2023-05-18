import 'package:flutter_amazon/consts/consts.dart';
import 'package:flutter_amazon/views/auth_screens/login_screen.dart';
import 'package:flutter_amazon/widgets_common/app_logo_widget.dart';
import 'package:flutter_amazon/widgets_common/bg_widget.dart';
import 'package:flutter_amazon/widgets_common/text_fields.dart';
import 'package:get/get.dart';

import '../../controllers/authController.dart';
import '../../widgets_common/custom_button.dart';
import '../../widgets_common/responsive_height.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  var controller = Get.put(AuthController());
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(Scaffold(
      body: SingleChildScrollView(
        child: GetBuilder<AuthController>(builder: (ctr) {
          return Center(
            child: Column(
              children: [
                myCommonheight(0.1),
                appLogoContainer(),
                myCommonheight(0.02),
                Column(children: [
                  customTextField(
                      title: email,
                      hint: emailHint,
                      ispass: false,
                      controller: emailController),
                  myCommonheight(0.02),
                  ctr.isLoader
                      ? const Center(
                          child: CircularProgressIndicator(color: redColor))
                      : const SizedBox(),
                  customButton(
                    onPressed: controller.isButtonDisabled
                        ? null
                        : () async {
                            await controller.handleForgotPassword(
                                email: emailController.text);
                            emailController.clear();
                            Get.offAll(() => const LoginScreen());
                          },
                    textcolor: Colors.white,
                    title: "Get Code",
                    buttonColor: redColor,
                  ).box.width(context.screenWidth - 100).make(),
                  myCommonheight(0.01),
                ])
                    .box
                    .white
                    .rounded
                    .padding(const EdgeInsets.all(16))
                    .shadowSm
                    .width(context.screenWidth - (context.height * 0.07))
                    .make()
              ],
            ),
          );
        }),
      ),
    ));
  }
}
