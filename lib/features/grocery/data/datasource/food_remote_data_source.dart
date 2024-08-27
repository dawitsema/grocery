import 'dart:convert';
import 'package:grocery/features/grocery/data/model/food_entity_model.dart';
import 'package:http/http.dart' as http;
import 'package:grocery/features/grocery/domain/entity/grocery_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exception.dart';

abstract class FoodRemoteDataSource {
  Future<List<FoodEntity>> getAllFood();
  Future<FoodEntity> getSpecificFood(String id);
}

class FoodRemoteDataSourceImpl implements FoodRemoteDataSource {
  final http.Client client;
  final SharedPreferences sharedPreferences;

  FoodRemoteDataSourceImpl(
      {required this.client, required this.sharedPreferences});

  final String urls =
      "https://g5-flutter-learning-path-be.onrender.com/api/v1/groceries";

  @override
  Future<List<FoodEntity>> getAllFood() async {
    final response = await client.get(
      Uri.parse(urls),
    );

    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body);
      final List<FoodEntity> foodList = (decodedJson['data'] as List)
          .map((food) => FoodEntityModel.fromJson(food))
          .toList();

      // Save to SharedPreferences
      await sharedPreferences.setString(
          'cached_food_list', json.encode(decodedJson['data']));

      return foodList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<FoodEntity> getSpecificFood(String id) async {
    final response = await client.get(
      Uri.parse('$urls/$id'),
    );

    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body);
      final foodEntity = FoodEntityModel.fromJson(decodedJson['data']);

      // Save to SharedPreferences
      await sharedPreferences.setString(
          'cached_food_$id', json.encode(decodedJson['data']));

      return foodEntity;
    } else {
      throw ServerException();
    }
  }
}
