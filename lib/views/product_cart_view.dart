import 'package:flutter/material.dart';

class ProductCartView extends StatefulWidget {
  @override
  _ProductCartViewState createState() => _ProductCartViewState();
}

class _ProductCartViewState extends State<ProductCartView> {
  final List<Map<String, dynamic>> _products = [
    {
      'name': 'Product 1',
      'price': 10.0,
      'quantity': 2,
      'image': 'https://via.placeholder.com/150',
    },
    {
      'name': 'Product 2',
      'price': 20.0,
      'quantity': 1,
      'image': 'https://via.placeholder.com/150',
    },
    {
      'name': 'Product 3',
      'price': 30.0,
      'quantity': 3,
      'image': 'https://via.placeholder.com/150',
    },
  ];

  double _subtotal = 0.0;
  double _tax = 0.0;
  double _total = 0.0;

  @override
  void initState() {
    super.initState();
    _calculateTotal();
  }

  void _calculateTotal() {
    double subtotal = 0.0;
    for (var product in _products) {
      subtotal += product['price'] * product['quantity'];
    }
    double tax = subtotal * 0.1;
    double total = subtotal + tax;
    setState(() {
      _subtotal = subtotal;
      _tax = tax;
      _total = total;
    });
  }

  void _incrementQuantity(int index) {
    setState(() {
      _products[index]['quantity']++;
      _calculateTotal();
    });
  }

  void _decrementQuantity(int index) {
    setState(() {
      if (_products[index]['quantity'] > 1) {
        _products[index]['quantity']--;
        _calculateTotal();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _products.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Image.network(_products[index]['image']),
                  title: Text(_products[index]['name']),
                  subtitle: Text('\$${_products[index]['price']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () => _decrementQuantity(index),
                      ),
                      Text('${_products[index]['quantity']}'),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => _incrementQuantity(index),
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
            trailing: Text('\$$_subtotal'),
          ),
          ListTile(
            title: const Text('Tax (10%)'),
            trailing: Text('\$$_tax'),
          ),
          ListTile(
            title: const Text('Total'),
            trailing: Text('\$$_total'),
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
