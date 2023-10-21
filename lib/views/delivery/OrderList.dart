import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';

import 'ItemList.dart';
import 'editOrder.dart';

class OrderList extends StatefulWidget {
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  List order = [];
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String selectedOrder = "";

  Future<List?> orderList() async {
    QuerySnapshot querySnapshot;
    List list = [];
    try {
      querySnapshot = await firestore.collection('approveOrder').get();

      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          print(doc.id);
          Map map = {
            "id": doc.id,
            "orderid": doc['orderid'],
            "location": doc['location'],
            "itemname": doc['itemname'],
            "price": doc['price'],
            "quantity": doc['quantity'],
            "receivedQuantity": doc['receivedQuantity'],
            "sendQuantity": doc['sendQuantity'],
            "status": doc['status'],
          };
          list.add(map);
        }
      }
      return list;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    this.orderList().then((value) => {
          setState(() {
            order = value!;
          }),
          print(value)
        });
  }

  void delete(String id) {
    firestore.collection('approveOrder').doc(id).delete();
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => super.widget));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Order List'),
          backgroundColor: Colors.grey[900],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: order.length,
                  itemBuilder: (context, index) {
                    final orderData = order[index];
                    return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 20.0),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onDismissed: (direction) {
                        delete(orderData['id'].toString());
                      },
                      child: Card(
                        elevation: 10,
                        color: Colors.white,
                        child: ListTile(
                          minLeadingWidth: 2,
                          leading: Image.asset(
                            'assets/images/OrderIco.png',
                            height: 120,
                          ),
                          title: Text(
                            'Order ID : ${orderData['orderid']}',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          contentPadding: EdgeInsets.all(8),
                          isThreeLine: true,
                          minVerticalPadding: 8,
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 4.0),
                              Text(
                                'location : ${orderData['location']}',
                                style: TextStyle(
                                    fontSize: 13.0, color: Colors.black),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                'Item: ${orderData['itemname']}',
                                style: TextStyle(
                                    fontSize: 13.0, color: Colors.black),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                'price : ${orderData['price']}',
                                style: TextStyle(
                                    fontSize: 13.0, color: Colors.black),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                'quantity : ${orderData['quantity']}',
                                style: TextStyle(
                                    fontSize: 13.0, color: Colors.black),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                'Received Quantity : ${orderData['receivedQuantity']}',
                                style: TextStyle(
                                    fontSize: 13.0, color: Colors.black),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                'Send Quantity : ${orderData['sendQuantity']}',
                                style: TextStyle(
                                    fontSize: 13.0, color: Colors.black),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                'Status : ${orderData['status']}',
                                style: TextStyle(
                                    fontSize: 13.0, color: Colors.black),
                              ),
                              SizedBox(height: 5.0),
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(width: 10.0),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Color.fromARGB(255, 6, 39, 52)),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EditOrder(
                                                sendQuantity:
                                                    orderData['sendQuantity']
                                                        .toString(),
                                                receivedQuantity: orderData[
                                                        'receivedQuantity']
                                                    .toString(),
                                                id: orderData['id'].toString()),
                                          ),
                                        );
                                      },
                                      child: Text('Update R Quantity'),
                                    ),
                                    SizedBox(width: 10.0),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Color.fromARGB(255, 6, 39, 52)),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        delete(orderData['id'].toString());
                                      },
                                      child: Text('Delete'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
