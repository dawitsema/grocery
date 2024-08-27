import 'package:get_it/get_it.dart';
import 'package:grocery/features/grocery/data/datasource/food_local_data_source.dart';
import 'package:grocery/features/grocery/data/datasource/food_remote_data_source.dart';
import 'package:grocery/features/grocery/data/repository/food_repository_impl.dart';
import 'package:grocery/features/grocery/domain/repository/grocery_repository.dart';
import 'package:grocery/features/grocery/domain/usecase/get_all_food.dart';
import 'package:grocery/features/grocery/domain/usecase/get_specific_food.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'features/grocery/presentation/bloc/food_bloc.dart';
import 'core/network/network_info.dart';

final serviceLocator = GetIt.instance;

Future<void> setupLocator() async {
  // Shared Preferences instance
  final sharedPreferences = await SharedPreferences.getInstance();

  // Internet Connection Checker instance
  final internetConnectionChecker = InternetConnectionChecker();

  // Registering dependencies
  serviceLocator.registerLazySingleton<http.Client>(() => http.Client());
  serviceLocator
      .registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  serviceLocator.registerLazySingleton(() => internetConnectionChecker);

  // Network Info
  serviceLocator.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(serviceLocator<InternetConnectionChecker>()));

  // Local Data Source
  serviceLocator.registerLazySingleton<FoodLocalDataSource>(() =>
      FoodLocalDataSourceImpl(
          sharedPreferences: serviceLocator<SharedPreferences>()));

  // Remote Data Source
  serviceLocator.registerLazySingleton<FoodRemoteDataSource>(
    () => FoodRemoteDataSourceImpl(
        client: serviceLocator<http.Client>(),
        sharedPreferences: serviceLocator<SharedPreferences>()),
  );

  // Repository
  serviceLocator.registerLazySingleton<FoodRepository>(() => FoodRepositoryImpl(
        localDataSource: serviceLocator<FoodLocalDataSource>(),
        remoteDataSource: serviceLocator<FoodRemoteDataSource>(),
        networkInfo: serviceLocator<NetworkInfo>(),
      ));

  // Use Cases
  serviceLocator.registerLazySingleton(
      () => GetAllFood(serviceLocator<FoodRepository>()));
  serviceLocator.registerLazySingleton(
      () => GetSpecificFood(serviceLocator<FoodRepository>()));

  // Bloc
  serviceLocator.registerFactory<FoodBloc>(() => FoodBloc(
        getAllFood: serviceLocator<GetAllFood>(),
        getSpecificFood: serviceLocator<GetSpecificFood>(),
      ));
}
