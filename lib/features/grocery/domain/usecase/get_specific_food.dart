import 'package:dartz/dartz.dart';
import 'package:grocery/features/grocery/domain/entity/grocery_entity.dart';

import '../../../../core/error/failure.dart';
import '../repository/grocery_repository.dart';

class GetSpecificFood {
  final FoodRepository repository;

  GetSpecificFood(this.repository);

  Future<Either<Failure, FoodEntity>> call(String id) async {
    return await repository.getSpecificFood(id);
  }
}
