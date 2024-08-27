import 'package:dartz/dartz.dart';
import 'package:grocery/core/error/exception.dart';
import 'package:grocery/core/error/failure.dart';
import 'package:grocery/features/grocery/domain/entity/grocery_entity.dart';
import 'package:grocery/core/network/network_info.dart';

import '../../domain/repository/grocery_repository.dart';
import '../datasource/food_local_data_source.dart';
import '../datasource/food_remote_data_source.dart';

class FoodRepositoryImpl implements FoodRepository {
  final FoodRemoteDataSource remoteDataSource;
  final FoodLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  FoodRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<FoodEntity>>> getAllFood() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteFood = await remoteDataSource.getAllFood();
        // Save data locally
        await localDataSource.cacheFoodList(remoteFood);
        return Right(remoteFood);
      } on ServerException {
        return Left(ServerFailure('Server Failure'));
      }
    } else {
      try {
        // Fetch locally cached data if offline
        final localFood = await localDataSource.getCachedFoodList();
        return Right(localFood);
      } on CacheException {
        return Left(CacheFailure('Cache Failure'));
      }
    }
  }

  @override
  Future<Either<Failure, FoodEntity>> getSpecificFood(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteFood = await remoteDataSource.getSpecificFood(id);
        // Save data locally
        await localDataSource.cacheFood(remoteFood);
        return Right(remoteFood);
      } on ServerException {
        return Left(ServerFailure('Server Failure'));
      }
    } else {
      try {
        // Fetch locally cached data if offline
        final localFood = await localDataSource.getCachedFoodById(id);
        return Right(localFood);
      } on CacheException {
        return Left(CacheFailure('Cache Failure'));
      }
    }
  }
}
