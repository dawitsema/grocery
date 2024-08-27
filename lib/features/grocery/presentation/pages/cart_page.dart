import 'package:flutter/material.dart';

import '../widgets/cart_item.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    // Handle back navigation
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(width: 50),
                Text('My Basket', style: TextStyle(fontSize: 20)),
              ],
            ),
            // List of Cart Items
            Expanded(
              child: ListView(
                children: [
                  CartItem(
                    name: 'Chicken Burger',
                    image: 'assets/images/food1.png',
                    originalPrice: 10.00,
                    discountedPrice: 6.00,
                    additionalOptionsPrice: 2.50,
                  ),
                  CartItem(
                    name: 'Ramen Noodles',
                    image: 'assets/images/food2.png',
                    originalPrice: 22.00,
                    discountedPrice: 15.00,
                  ),
                  CartItem(
                    name: 'Cherry Tomato Salad',
                    image: 'assets/images/food3.png',
                    originalPrice: 8.00,
                    discountedPrice: 8.00,
                  ),
                ],
              ),
            ),
            // Order Summary
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildSummaryRow('Subtotal', '£31.50'),
                  _buildSummaryRow('Delivery Fee', 'FREE'),
                  _buildSummaryRow('Discount', '- £6.30'),
                  Divider(),
                  _buildSummaryRow('Total', '£25.20'),
                  SizedBox(height: 16),
                  Row(children: [
                    Text(
                      "25.50",
                      style: TextStyle(
                        fontFamily: 'roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle place order action
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Color.fromRGBO(255, 99, 72, 1),
                        ),
                        child: Text('Place Order',
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                    )
                  ]
                      //here
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String title, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontSize: 16)),
        Text(amount,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ],
    );
  }
}
