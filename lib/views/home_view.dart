import 'package:flutter/material.dart';
import './shopping_cart_view/shopping_cart_screen.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Home page'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShoppingCartScreen()),
                );
              },
              child: Text('Go to Shopping Cart'),
            ),
          ],
        ),
      ),
    );
  }
}


