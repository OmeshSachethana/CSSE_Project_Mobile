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
                  leading: Image.network(cart.products[index]['imageUrl'] ?? ''),
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
            onPressed: () {},
            child: const Text('Place Order'),
          ),
        ],
      ),
    );
  }
}
