import 'package:flutter_amazon/consts/consts.dart';
import 'package:flutter_amazon/controllers/home_controller.dart';
import 'package:flutter_amazon/views/profile_screens/profile_screen.dart';
import 'package:flutter_amazon/views/home_screens/home_screen.dart';
import 'package:get/get.dart';

import '../category_screens/category_screen.dart';
import '../cart_screens/cart_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    List<BottomNavigationBarItem> navBarItems = [
      BottomNavigationBarItem(
          icon: Image.asset(
            icHome,
            width: 26,
          ),
          label: home),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCategories,
            width: 26,
          ),
          label: category),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCart,
            width: 26,
          ),
          label: cart),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProfile,
            width: 26,
          ),
          label: account),
    ];
    List navBarPages = [
      const HomeScreen(),
      const CategoryScreen(),
      const CartScreen(),
      const ProfileScreen()
    ];
    return Scaffold(
      body: Obx(
        () => Column(
          children: [Expanded(child: navBarPages[controller.navIndex.value])],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
            currentIndex: controller.navIndex.value,
            selectedItemColor: redColor,
            selectedLabelStyle: const TextStyle(fontFamily: semibold),
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            onTap: (value) {
              controller.navIndex.value = value;
            },
            items: navBarItems),
      ),
    );
  }
}
