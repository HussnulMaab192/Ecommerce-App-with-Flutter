import 'package:flutter_amazon/controllers/authController.dart';
import 'package:get/get.dart';

import '../../consts/consts.dart';
import '../../widgets_common/app_logo_widget.dart';
import '../../widgets_common/bg_widget.dart';
import '../../widgets_common/custom_button.dart';
import '../../widgets_common/responsive_height.dart';
import '../../widgets_common/text_fields.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool ischecked = false;

  var controller = Get.put(AuthController());
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: GetBuilder<AuthController>(builder: (ctr) {
          return Builder(builder: (context) {
            return Center(
              child: Column(
                children: [
                  myCommonheight(0.1),
                  appLogoContainer(),
                  myCommonheight(0.06),
                  Column(children: [
                    customTextField(
                        ispass: false,
                        title: name,
                        hint: nameHint,
                        controller: nameController),
                    myCommonheight(0.01),
                    customTextField(
                        ispass: false,
                        title: email,
                        hint: emailHint,
                        controller: emailController),
                    myCommonheight(0.01),
                    customTextField(
                        ispass: true,
                        title: password,
                        hint: passwordHint,
                        controller: passwordController),
                    myCommonheight(0.01),
                    customTextField(
                        ispass: true,
                        title: retypePassword,
                        hint: passwordHint,
                        controller: confirmController),
                    Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {},
                            child: forgetPassword.text.make())),
                    Row(
                      children: [
                        Checkbox(
                            activeColor: redColor,
                            value: ischecked,
                            onChanged: (newValue) {
                              setState(() {
                                ischecked = newValue!;
                              });
                            }),
                        Expanded(
                          child: RichText(
                              text: const TextSpan(children: [
                            TextSpan(
                              text: "I agree to the ",
                              style: TextStyle(
                                fontFamily: bold,
                                color: fontGrey,
                              ),
                            ),
                            TextSpan(
                              text: termsConditions,
                              style: TextStyle(
                                fontFamily: regular,
                                color: redColor,
                              ),
                            ),
                            TextSpan(
                              text: " & ",
                              style: TextStyle(
                                fontFamily: bold,
                                color: fontGrey,
                              ),
                            ),
                            TextSpan(
                              text: myprivacyPolicy,
                              style: TextStyle(
                                fontFamily: regular,
                                color: redColor,
                              ),
                            ),
                          ])),
                        )
                      ],
                    ),
                    myCommonheight(0.005),
                    ctr.isLoader
                        ? const Center(
                            child: CircularProgressIndicator(color: redColor))
                        : const SizedBox(),
                    customButton(
                      onPressed: () async {
                        if (ischecked) {
                          print("in the signup button *****************");
                          await controller.signUpMethod(
                              email: emailController.text,
                              password: passwordController.text,
                              name: nameController.text);
                        }
                      },
                      textcolor: ischecked == true ? Colors.white : redColor,
                      title: signUp,
                      buttonColor: ischecked == true ? redColor : lightGrey,
                    ).box.width(context.screenWidth - 100).make(),
                    myCommonheight(0.01),
                    RichText(
                        text: const TextSpan(children: [
                      TextSpan(
                        text: alreadyHaveAnAccount,
                        style: TextStyle(
                          fontFamily: bold,
                          color: fontGrey,
                        ),
                      ),
                      TextSpan(
                        text: login,
                        style: TextStyle(
                          fontFamily: bold,
                          color: redColor,
                        ),
                      ),
                    ])).onTap(() {
                      Get.back();
                    })
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
          });
        }),
      ),
    ));
  }
}
