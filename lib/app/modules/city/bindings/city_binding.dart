import 'package:get/get.dart';

import 'package:flutter_exam/app/modules/city/controllers/city_controller.dart';

class CityBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CityController());
  }
}
