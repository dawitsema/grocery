import 'package:flutter/material.dart';

class CartItem extends StatefulWidget {
  final String name;
  final String image;
  final double originalPrice;
  final double discountedPrice;
  final double additionalOptionsPrice;

  CartItem({
    required this.name,
    required this.image,
    required this.originalPrice,
    required this.discountedPrice,
    this.additionalOptionsPrice = 0.0,
  });

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
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
    return Column(
      children: [
        Row(
          children: [
            Image.asset(
              widget.image,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(
                        '£${widget.originalPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '£${widget.discountedPrice.toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: _decreaseQuantity,
                      ),
                      Text('$_quantity'),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: _increaseQuantity,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.close, color: Colors.grey),
              onPressed: () {
                // Handle remove item from cart
              },
            ),
          ],
        ),
        if (widget.additionalOptionsPrice > 0) ...[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Add Cheese'),
                  Spacer(),
                  Text("£0.50"),
                ],
              ),
              Row(
                children: [
                  Text('Add Meat (Extra Patty)'),
                  Spacer(),
                  Text('£2.00'),
                ],
              ),
            ],
          ),
        ],
        Divider(),
      ],
    );
  }
}
