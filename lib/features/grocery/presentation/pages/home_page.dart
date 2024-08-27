import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/dependency_injection.dart';
import 'package:grocery/features/grocery/domain/usecase/get_all_food.dart';
import 'package:grocery/features/grocery/presentation/bloc/food_bloc.dart';

import '../widgets/food_card.dart';
import 'detail_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<FoodBloc>()..add(LoadAllFoodEvent()),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              // Logo and Title Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/foodlogo.png',
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Burger',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'roboto',
                      ),
                    ),
                  ],
                ),
              ),
              // Search Bar Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.filter_list),
                            onPressed: () {
                              // Implement filter functionality
                            },
                          ),
                          hintText: 'Search',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade300,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              // Food Cards Grid
              BlocConsumer<FoodBloc, FoodState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  if (state is FoodLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is LoadedAllFoodState) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16.0,
                            mainAxisSpacing: 16.0,
                            childAspectRatio: 0.8,
                          ),
                          itemCount: state.foods.length,
                          itemBuilder: (context, index) {
                            return FoodCard(
                              foodItem: state.foods[index],
                            );
                          },
                        ),
                      ),
                    );
                  } else if (state is FoodErrorState) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
