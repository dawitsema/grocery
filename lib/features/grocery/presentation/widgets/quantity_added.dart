import 'package:flutter/material.dart';
import 'package:grocery/features/grocery/presentation/pages/cart_page.dart';

class QuantityAndAddToBasket extends StatefulWidget {
  @override
  _QuantityAndAddToBasketState createState() => _QuantityAndAddToBasketState();
}

class _QuantityAndAddToBasketState extends State<QuantityAndAddToBasket> {
  int _quantity = 1;

  void _increaseQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decreaseQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          // Quantity Selector
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove, color: Colors.black),
                onPressed: _decreaseQuantity,
              ),
              Text(
                '$_quantity',
                style: TextStyle(fontSize: 18),
              ),
              IconButton(
                icon: Icon(Icons.add, color: Colors.black),
                onPressed: _increaseQuantity,
              ),
            ],
          ),
          SizedBox(width: 16),
          // Add to Basket Button
          Expanded(
            child: ElevatedButton.icon(
              icon: Icon(Icons.shopping_bag_rounded, color: Colors.white),
              label: Text('Add to Basket',
                  style: TextStyle(color: Colors.white, fontFamily: 'roboto')),
              onPressed: () {
                // Handle add to basket action
                print("Added $_quantity items to basket");
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return CartPage();
                }));
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14),
                backgroundColor: Color.fromRGBO(
                    255, 99, 72, 1), // Use the color that matches your design
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
