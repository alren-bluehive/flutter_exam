import 'package:get/get.dart';

import '../modules/city/bindings/city_binding.dart';
import '../modules/city/views/city_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.HOME;
  static const city = Routes.CITY;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.CITY,
      page: () => const CityView(),
      binding: CityBinding(),
    ),
  ];
}
