// ignore_for_file: constant_identifier_names

import 'dart:convert';

// I used data model to represent structured data in a typed and organized manner
// It also helps on making the code more maintainable as data transformation will be easier using this
class CityData {
  static const NAME = 'name';
  static const IMAGE_URL = 'image_url';
  static const TEMP = 'temp';
  static const UNIT = 'unit';

  final String name;
  final String imageUrl;
  final double temp;
  final String unit;

  CityData({
    required this.name,
    required this.imageUrl,
    required this.temp,
    required this.unit,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': NAME,
      'imageUrl': IMAGE_URL,
      'temp': TEMP,
      'unit': UNIT,
    };
  }

  factory CityData.fromMap(Map<String, dynamic> map) {
    return CityData(
      name: map[NAME] as String,
      imageUrl: map[IMAGE_URL] as String,
      temp: map[TEMP] as double,
      unit: map[UNIT] as String,
    );
  }

  factory CityData.empty() {
    return CityData(
      name: 'Empty',
      imageUrl: 'https://via.placeholder.com/400',
      temp: 0.0,
      unit: '?',
    );
  }

  String toJson() => json.encode(toMap());

  factory CityData.fromJson(String source) =>
      CityData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CityData(name: $name, imageUrl: $imageUrl, temp: $temp, unit: $unit)';
  }
}
