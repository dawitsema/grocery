import 'dart:convert';
import 'package:grocery/features/grocery/data/model/food_entity_model.dart';
import 'package:grocery/features/grocery/domain/entity/grocery_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exception.dart';

abstract class FoodLocalDataSource {
  Future<List<FoodEntity>> getCachedFoodList();
  Future<void> cacheFoodList(List<FoodEntity> foodList);

  Future<FoodEntity> getCachedFoodById(String id);
  Future<void> cacheFood(FoodEntity food);
}

const CACHED_FOOD_LIST = 'CACHED_FOOD_LIST';

class FoodLocalDataSourceImpl implements FoodLocalDataSource {
  final SharedPreferences sharedPreferences;

  FoodLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<FoodEntity>> getCachedFoodList() async {
    final jsonString = sharedPreferences.getString(CACHED_FOOD_LIST);

    if (jsonString != null) {
      final List<dynamic> decodedJson = json.decode(jsonString);
      final List<FoodEntity> foodList = decodedJson
          .map<FoodEntity>((foodJson) => FoodEntityModel.fromJson(foodJson))
          .toList();
      return foodList;
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheFoodList(List<FoodEntity> foodList) async {
    final List<Map<String, dynamic>> foodJsonList = foodList
        .map<Map<String, dynamic>>((food) => (food as FoodEntityModel).toJson())
        .toList();

    final jsonString = json.encode(foodJsonList);
    await sharedPreferences.setString(CACHED_FOOD_LIST, jsonString);
  }

  @override
  Future<FoodEntity> getCachedFoodById(String id) async {
    final jsonString = sharedPreferences.getString('CACHED_FOOD_$id');

    if (jsonString != null) {
      final Map<String, dynamic> decodedJson = json.decode(jsonString);
      return FoodEntityModel.fromJson(decodedJson);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheFood(FoodEntity food) async {
    final foodJson = (food as FoodEntityModel).toJson();
    final jsonString = json.encode(foodJson);

    await sharedPreferences.setString('CACHED_FOOD_${food.id}', jsonString);
  }
}
