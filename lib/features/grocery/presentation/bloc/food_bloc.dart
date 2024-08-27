import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grocery/features/grocery/domain/entity/grocery_entity.dart';

import '../../domain/usecase/get_all_food.dart';
import '../../domain/usecase/get_specific_food.dart';

part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  final GetAllFood getAllFood;
  final GetSpecificFood getSpecificFood;

  FoodBloc({
    required this.getAllFood,
    required this.getSpecificFood,
  }) : super(FoodInitial()) {
    // Handle LoadAllFoodEvent
    on<LoadAllFoodEvent>((event, emit) async {
      emit(FoodLoading());
      final failureOrFoods = await getAllFood();

      failureOrFoods.fold(
        (failure) {
          emit(FoodErrorState(failure.message));
        },
        (foods) {
          emit(LoadedAllFoodState(foods));
        },
      );
    });

    // Handle GetSpecificFoodEvent
    on<GetSpecificFoodEvent>((event, emit) async {
      emit(FoodLoading());
      final failureOrFood = await getSpecificFood(event.foodId);
      failureOrFood.fold(
        (failure) => emit(FoodErrorState("Failed to load food item")),
        (food) => emit(LoadedSpecificFoodState(food)),
      );
    });
  }
}
