import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exam/app/api/city_api.dart';
import 'package:flutter_exam/app/models/city_data_model.dart';
import 'package:get/get.dart';

// Instead of using variable bool? hasError var _l = true, I used enum for status
// This offers much easier way of checking the current status
// A bool? hasError cannot be used for conditional checking it should be a bool
// var _l = true is not super descriptive name and might cause confusion in the future
// These problems are now solved by using a much descriptive enum
enum CityStatus { initial, fetching, succeeded, hasError }

// I used a separate controller to handle state management
// Using a stateful widget to handle states is quite good for small applications
// But it might not be the most scalable and maintainable approach for complex applications.
// As the application grows in complexity, managing multiple states and their interactions can become difficult with StatefulWidget alone.
// It can lead to spaghetti code
class CityController extends GetxController {
  static CityController get find => Get.find();
  late Worker _statusEverWorker;

  late TextEditingController _cityController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _status = CityStatus.initial.obs;
  // Change this from d to _cityData, always use descriptive name for variable names
  // Using descriptive names for variables is considered a best practice in software development.
  // Descriptive names make your code more readable, understandable, and maintainable
  final _cityData = CityData.empty().obs;
  final _history = 'None'.obs;
  final _errorMessage = ''.obs;

  TextEditingController get cityController => _cityController;
  GlobalKey<FormState> get formKey => _formKey;
  bool get isLoading => _status.value == CityStatus.fetching;
  bool get hasError => _status.value == CityStatus.hasError;
  CityData get cityData => _cityData.value;
  String get errorMessage => _errorMessage.value;
  String get history => _history.value;

  String currentState() => 'ExhibitorController(_status: ${_status.value})';

  @override
  void onInit() {
    super.onInit();
    if (kDebugMode) {
      print(currentState());
    }
    _cityController = TextEditingController();
    _monitorCityStatus();
  }

  @override
  void onClose() {
    // need to dispose TextEditingController when not in need
    // ensure that any resources held by the TextEditingController are properly released
    // this avoids potential memory leaks and improving the overall performance
    _cityController.dispose();
    _statusEverWorker.dispose();
    super.onClose();
  }

  void _monitorCityStatus() {
    _statusEverWorker = ever(
      _status,
      (value) {
        switch (value) {
          case CityStatus.hasError:
            if (kDebugMode) {
              print(currentState());
            }
            break;
          case CityStatus.fetching:
            if (kDebugMode) {
              print(currentState());
            }
            break;
          case CityStatus.initial:
            if (kDebugMode) {
              print(currentState());
            }
            break;
          case CityStatus.succeeded:
            if (kDebugMode) {
              print(currentState());
            }
            break;
        }
      },
    );
  }

  // Added a try catch for proper error handling
  Future<void> fetchCityData(String userToken) async {
    _status.value = CityStatus.fetching;
    try {
      final city = cityController.text.trim().toLowerCase();
      // Api only accepts Berlin, Manila or Tokyo as valid input
      // It will throw an error for other cities
      final response = await CityApi.fetchCityData(
        city,
        token: userToken,
      );
      if (kDebugMode) {
        print(response);
      }
      _cityData.value = response;
      _history.value = response.name;
      _status.value = CityStatus.succeeded;
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      _errorMessage.value = error.toString();
      _status.value = CityStatus.hasError;
    }
  }
}
