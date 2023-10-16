import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeliveryUpdateScreen extends StatefulWidget {
  final String orderId;

  DeliveryUpdateScreen({required this.orderId});

  @override
  _DeliveryUpdateScreenState createState() => _DeliveryUpdateScreenState();
}

class _DeliveryUpdateScreenState extends State<DeliveryUpdateScreen> {
  late List<Map<String, dynamic>> products;

  @override
  void initState() {
    super.initState();
    // Load order details and products when the screen is initialized
    loadOrderDetails();
  }

  void loadOrderDetails() async {
    // Fetch order details and products from Firestore
    DocumentSnapshot orderSnapshot = await FirebaseFirestore.instance
        .collection('orders')
        .doc(widget.orderId)
        .get();

    setState(() {
      products = List<Map<String, dynamic>>.from(orderSnapshot['products']);
    });
  }

  void updateDeliveredQuantity(int index, int newQuantity) {
    // Update the delivered quantity for the product at the specified index
    products[index]['deliveredQuantity'] = newQuantity;

    // Save the updated product data to Firestore
    FirebaseFirestore.instance.collection('orders').doc(widget.orderId).update({
      'products': products,
    });

    // Refresh the screen to reflect the changes
    loadOrderDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Delivered Quantity'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index]['productName']),
            subtitle: Text('Quantity: ${products[index]['quantity']}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Delivered: ${products[index]['deliveredQuantity']}'),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    updateDeliveredQuantity(
                        index, products[index]['deliveredQuantity'] + 1);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    if (products[index]['deliveredQuantity'] > 0) {
                      updateDeliveredQuantity(
                          index, products[index]['deliveredQuantity'] - 1);
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
