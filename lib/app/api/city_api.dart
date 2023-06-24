import 'dart:math';

import 'package:flutter_exam/app/models/city_data_model.dart';

// Simulate an api
class CityApi {
  static const String validToken = 'valid_token';

  static Future<CityData> fetchCityData(String city, {required String token}) {
    return Future.delayed(const Duration(seconds: 2), () {
      late String jsonResponse;

      if (token != validToken) {
        throw Exception(
          'Unauthorized. You must be logged in to perform this action',
        );
      }

      final random = Random();
      final randomQuery = random.nextInt(1000).toString();
      final imageUrl =
          'https://source.unsplash.com/400x400/?random=$randomQuery';

      switch (city) {
        case 'manila':
          jsonResponse = '''
            {
              "name": "Manila",
              "image_url": "$imageUrl",
              "temp": 30.2,
              "unit": "Celsius"
            }
          ''';
          break;
        case 'berlin':
          jsonResponse = '''
            {
              "name": "Berlin",
              "image_url": "$imageUrl",
              "temp": 18.5,
              "unit": "Celsius"
            }
          ''';
          break;
        case 'tokyo':
          jsonResponse = '''
            {
              "name": "Tokyo",
              "image_url": "$imageUrl",
              "temp": 22.8,
              "unit": "Celsius"
            }
          ''';
          break;
        case 'moscow':
          jsonResponse = '''
            {
              "name": "Moscow",
              "image_url": "$imageUrl",
              "temp": 11.0,
              "unit": "Celsius"
            }
          ''';
          break;
        default:
          jsonResponse = '''
            {
              "status": "Failed",
              "message": "Unable to get city data"
            }
          ''';
          throw Exception('No City Data Found');
      }

      final cityData = CityData.fromJson(jsonResponse);
      return cityData;
    });
  }
}
