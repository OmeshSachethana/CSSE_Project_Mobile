import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartView extends StatefulWidget {
  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart View'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('orders').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var orderList = snapshot.data?.docs;

          return ListView.builder(
            itemCount: orderList?.length,
            itemBuilder: (context, index) {
              var orderData = orderList?[index].data() as Map<String, dynamic>;
              String orderId = orderList![index].id;

              return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  title: Text('Order ID: $orderId'),
                  subtitle: Text('Customer Name: ${orderData['customerName']}'),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    // Navigate to the order details screen with orderId
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            OrderDetailsScreen(orderId: orderId),
                      ),
                    );
                  },
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
            return Center(child: CircularProgressIndicator());
          }

          var orderData = snapshot.data?.data() as Map<String, dynamic>;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                title: Text('Order ID: $orderId'),
                subtitle: Text('Customer Name: ${orderData['customerName']}'),
              ),
              // Display other order details here
              Divider(),
              Text('Order Details:'),
              // You can display other order details here
              // Example: Text('Total Price: ${orderData['totalPrice']}'),
              ElevatedButton(
                onPressed: () {
                  // Implement the logic to assign a driver to this order
                  // You can show a dialog or perform any necessary actions.
                },
                child: Text('Assign Driver'),
              ),
            ],
          );
        },
      ),
    );
  }
}
