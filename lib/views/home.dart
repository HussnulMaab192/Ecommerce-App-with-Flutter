import 'package:flutter_amazon/consts/consts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> navBarItems = [
      BottomNavigationBarItem(
          icon: Image.asset(
            icHome,
            width: 30,
          ),
          label: home),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCategories,
            width: 30,
          ),
          label: category),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCart,
            width: 30,
          ),
          label: cart),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProfile,
            width: 30,
          ),
          label: account),
    ];

    return Scaffold(
      body: Container(),
      bottomNavigationBar: BottomNavigationBar(items: navBarItems),
    );
  }
}
