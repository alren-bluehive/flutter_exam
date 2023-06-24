import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_exam/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_exam/app/routes/app_pages.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Get.toNamed(AppPages.city),
          child: const Text('GO TO CITY PAGE'),
        ),
      ),
    );
  }
}
