import 'package:flutter_amazon/consts/consts.dart';
import 'package:flutter_amazon/views/splash_views/splash_screen.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
        iconTheme: const IconThemeData(color: darkFontGrey),
        fontFamily: regular,
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
            color: Colors.transparent,
            iconTheme: IconThemeData(color: darkFontGrey)),
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
