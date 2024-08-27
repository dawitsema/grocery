part of 'food_bloc.dart';

abstract class FoodEvent extends Equatable {
  const FoodEvent();

  @override
  List<Object> get props => [];
}

class LoadAllFoodEvent extends FoodEvent {}

class GetSpecificFoodEvent extends FoodEvent {
  final String foodId;

  const GetSpecificFoodEvent(this.foodId);

  @override
  List<Object> get props => [foodId];
}
