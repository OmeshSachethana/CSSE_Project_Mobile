import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeliveryDetails extends StatefulWidget {
  @override
  _DeliveryDetailsState createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delivery Details'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('delivery').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var deliveryList = snapshot.data?.docs;

          return ListView.builder(
            itemCount: deliveryList?.length,
            itemBuilder: (context, index) {
              var deliveryData =
                  deliveryList?[index].data() as Map<String, dynamic>;

              return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  title: Text('Order ID: ${deliveryData['orderId']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Customer Name: ${deliveryData['customerName']}'),
                      Text(
                          'Delivery Address: ${deliveryData['deliveryAddress']}'),
                      Text('Delivery Status: ${deliveryData['status']}'),
                      Text('Delivery Date: ${deliveryData['deliveryDate']}'),
                    ],
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
