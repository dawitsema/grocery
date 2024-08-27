part of 'food_bloc.dart';

abstract class FoodState extends Equatable {
  const FoodState();

  @override
  List<Object> get props => [];
}

class FoodInitial extends FoodState {}

class FoodLoading extends FoodState {}

class LoadedAllFoodState extends FoodState {
  final List<FoodEntity> foods;

  const LoadedAllFoodState(this.foods);

  @override
  List<Object> get props => [foods];
}

class LoadedSpecificFoodState extends FoodState {
  final FoodEntity food;

  const LoadedSpecificFoodState(this.food);

  @override
  List<Object> get props => [food];
}

class FoodErrorState extends FoodState {
  final String message;

  const FoodErrorState(this.message);

  @override
  List<Object> get props => [message];
}
