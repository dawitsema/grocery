import 'package:dartz/dartz.dart';
import 'package:grocery/features/grocery/domain/entity/grocery_entity.dart';

import '../../../../core/error/failure.dart';
import '../repository/grocery_repository.dart';

class GetAllFood {
  final FoodRepository repository;

  GetAllFood(this.repository);

  Future<Either<Failure, List<FoodEntity>>> call() async {
    return await repository.getAllFood();
  }
}
