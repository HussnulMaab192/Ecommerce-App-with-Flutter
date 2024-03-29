import 'package:flutter_amazon/consts/consts.dart';
import 'package:flutter_amazon/views/auth_screens/forget_passwd.dart';
import 'package:flutter_amazon/views/auth_screens/sign_up.dart';
import 'package:flutter_amazon/widgets_common/app_logo_widget.dart';
import 'package:flutter_amazon/widgets_common/bg_widget.dart';
import 'package:flutter_amazon/widgets_common/text_fields.dart';
import 'package:get/get.dart';

import '../../controllers/authController.dart';
import '../../lists.dart';
import '../../widgets_common/custom_button.dart';
import '../../widgets_common/responsive_height.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var controller = Get.put(AuthController());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
                "Log in to $appname"
                    .text
                    .fontFamily(bold)
                    .white
                    .size(16)
                    .make(),
                myCommonheight(0.02),
                Column(children: [
                  customTextField(
                      title: email,
                      hint: emailHint,
                      ispass: false,
                      controller: emailController),
                  myCommonheight(0.02),
                  customTextField(
                      title: password,
                      hint: passwordHint,
                      ispass: true,
                      controller: passwordController),
                  myCommonheight(0.01),
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () async {
                            await Get.to(const ForgetPasswordScreen());
                          },
                          child: forgetPassword.text.make())),
                  ctr.isLoader
                      ? const Center(
                          child: CircularProgressIndicator(color: redColor))
                      : const SizedBox(),
                  customButton(
                    onPressed: () async {
                      print("inside login button");
                      await controller.loginMethod(
                          email: emailController.text,
                          password: passwordController.text);
                    },
                    textcolor: Colors.white,
                    title: login,
                    buttonColor: redColor,
                  ).box.width(context.screenWidth - 100).make(),
                  myCommonheight(0.01),
                  createNewAccount.text.color(fontGrey).make(),
                  myCommonheight(0.01),
                  customButton(
                    onPressed: () {
                      Get.to(() => const SignUpScreen());
                    },
                    textcolor: redColor,
                    title: signUp,
                    buttonColor: lightGolden,
                  ).box.width(context.screenWidth - 100).make(),
                  myCommonheight(0.01),
                  loginWith.text.color(fontGrey).make(),
                  myCommonheight(0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        3,
                        (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: lightGrey,
                                radius: 25,
                                child: Image.asset(
                                  iconList[index],
                                  width: 36,
                                ),
                              ),
                            )),
                  )
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
