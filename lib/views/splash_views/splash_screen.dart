import 'package:flutter_amazon/views/auth_screens/login_screen.dart';
import 'package:flutter_amazon/views/home_screens/home.dart';
import 'package:flutter_amazon/widgets_common/app_logo_widget.dart';
import 'package:get/get.dart';
import '../../consts/consts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkAlreadyLoginUisngFirebase();
    // checkalreadyLogin();
    super.initState();
  }

  checkAlreadyLoginUisngFirebase() {
    if (auth.currentUser != null) {
      // User is already logged in, redirect to home screen
      Future.delayed(const Duration(seconds: 3), () {
        Get.to(() => const Home());
      });
    } else {
      Future.delayed(const Duration(seconds: 3), () {
        Get.to(() => const LoginScreen());
      });
    }
  }

  // as i am checking the user from fire base so i dont have need of
  // shared preferance.but the below code is working fine
  // checkalreadyLogin() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  //   print("the value of isLoggedIn is $isLoggedIn");
  //   if (isLoggedIn) {
  //     // User is already logged in, redirect to home screen
  //     Future.delayed(const Duration(seconds: 3), () {
  //       Get.to(() => const Home());
  //     });
  //   } else {
  //     Future.delayed(const Duration(seconds: 3), () {
  //       Get.to(() => const LoginScreen());
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                icSplashBg,
                width: 300,
              ),
            ),
            20.heightBox,
            appLogoContainer(),
            10.heightBox,
            appname.text.fontFamily(bold).white.size(22).make(),
            5.heightBox,
            appversion.text.white.make(),
            const Spacer(),
            credits.text.white.fontFamily(semibold).make(),
            25.heightBox,
          ],
        ),
      ),
    );
  }
}
