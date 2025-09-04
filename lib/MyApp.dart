import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro006/controladores/controlador.dart';
import 'package:pro006/homePage.dart';
import 'package:pro006/loginPage.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.find();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        cardColor: const Color(0xFFF0F4F8),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF3B5998),
          elevation: 0,
        ),
      ),
      home: Obx(
        () =>
            controller.isLoggedIn.value ? const HomePage() : const LoginPage(),
      ),
    );
  }
}
