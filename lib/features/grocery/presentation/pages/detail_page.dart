import 'package:flutter/material.dart';
import 'package:grocery/features/grocery/presentation/pages/cart_page.dart';

import '../../domain/entity/grocery_entity.dart';
import '../widgets/quantity_added.dart';

class FoodDetailPage extends StatelessWidget {
  final FoodEntity foodItem;
  const FoodDetailPage({required this.foodItem, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              // Food Image
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  foodItem.imageUrl,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              // Back Button
              Positioned(
                top: 25,
                left: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      // Handle like action
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              // Like Button
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.favorite_border, color: Colors.red),
                    onPressed: () {
                      // Handle like action
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (_) => CartPage(),
                      //   ),
                      // );
                    },
                  ),
                ),
              ),
            ],
          ),
          // Food Description and Options
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    foodItem.title, // Replace with dynamic data
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '£${foodItem.price.toStringAsFixed(2)}', // Replace with dynamic data
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '£${foodItem.discount.toStringAsFixed(2)}', // Replace with dynamic data
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      SizedBox(width: 4),
                      Text(
                        '${foodItem.rating} (1,205)', // Replace with dynamic data
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          // Handle see all reviews action
                        },
                        child: Text(
                          'See all review',
                          style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    foodItem.description,
                    style: TextStyle(color: Colors.black87),
                  ),
                  TextButton(
                    onPressed: () {
                      // Handle see more action
                    },
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'See more',
                        style: TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Additional Options:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),

                  OptionItem(name: "Add Beaf", price: 1.5),
                  OptionItem(name: "Add Cheese", price: 0.5),
                  OptionItem(name: "Add Bacon", price: 1.0),

                  Spacer(),
                  QuantityAndAddToBasket(),
                  // Add to Basket Section
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OptionItem extends StatefulWidget {
  final String name;
  final double price;

  const OptionItem({required this.name, required this.price});

  @override
  _OptionItemState createState() => _OptionItemState();
}

class _OptionItemState extends State<OptionItem> {
  bool _isSelected = false; // Initial state of the checkbox

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(widget.name)),
        Text('+ £${widget.price.toStringAsFixed(2)}'),
        Checkbox(
          value: _isSelected,
          onChanged: (value) {
            setState(() {
              _isSelected = value!;
            });
          },
        ),
      ],
    );
  }
}
