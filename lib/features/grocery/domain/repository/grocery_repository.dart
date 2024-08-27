import 'package:grocery/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:grocery/features/grocery/domain/entity/grocery_entity.dart';

abstract class FoodRepository {
  Future<Either<Failure, List<FoodEntity>>> getAllFood();
  Future<Either<Failure, FoodEntity>> getSpecificFood(String id);
}
