import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('order').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          var orders = snapshot.data?.docs;

          return ListView.builder(
            itemCount: orders?.length,
            itemBuilder: (context, index) {
              var orderData = orders?[index].data();
              return Card(
                child: ListTile(
                  title: Text('Order ID: ${orders?[index].id}'),
                  subtitle:
                      Text('Customer Name: ${orderData?['customerName']}'),
                  trailing: IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: () {
                      // Navigate to order details screen and pass the order ID
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            OrderDetailsScreen(orderId: orders![index].id),
                      ));
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class OrderDetailsScreen extends StatelessWidget {
  final String orderId;

  OrderDetailsScreen({required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: FutureBuilder(
        future:
            FirebaseFirestore.instance.collection('orders').doc(orderId).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          var orderData = snapshot.data?.data() as Map<String, dynamic>;

          return Column(
            children: <Widget>[
              Text('Order ID: $orderId'),
              Text('Customer Name: ${orderData['customerName']}'),
              // Display other order details here
            ],
          );
        },
      ),
    );
  }
}
