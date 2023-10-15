import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';

class ProductCartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.products.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading:
                      Image.network(cart.products[index]['imageUrl'] ?? ''),
                  title: Text(cart.products[index]['name'] ?? ''),
                  subtitle: Text('\$${cart.products[index]['price'] ?? ''}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () => cart.decrementQuantity(index),
                      ),
                      Text('${cart.products[index]['quantity']}'),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => cart.incrementQuantity(index),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => cart.removeProduct(index),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Subtotal'),
            trailing: Text('\$${cart.subtotal}'),
          ),
          ListTile(
            title: const Text('Tax (10%)'),
            trailing: Text('\$${cart.tax}'),
          ),
          ListTile(
            title: const Text('Total'),
            trailing: Text('\$${cart.total}'),
          ),
          ElevatedButton(
            onPressed: () {
              placeOrder(cart);
              cart.clearCart();
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Order Status'),
                    content:
                        const Text('Order successfully sent for approval!'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: const Text('Place Order'),
          ),
        ],
      ),
    );
  }
}

void placeOrder(CartModel cart) {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    FirebaseFirestore.instance.collection('orders').add({
      'userRef': FirebaseFirestore.instance.collection('users').doc(user.uid),
      'approveStatus': "pending",
      'date': DateTime.now().toIso8601String(),
      'products': cart.products
          .map((product) => {
                'description': product['description'],
                'image': product['imageUrl'],
                'name': product['name'],
                'price': product['price'],
                'quantity': product['quantity'],
              })
          .toList(),
      'totalPrice': cart.total,
    });
  } else {
    print("No user is currently logged in.");
  }
}
