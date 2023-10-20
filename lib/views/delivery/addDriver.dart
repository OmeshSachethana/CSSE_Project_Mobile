import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddDriver extends StatefulWidget {
  @override
  _AddDriverState createState() => _AddDriverState();
}

class _AddDriverState extends State<AddDriver> {
  final List<String> driver = [
    'Select Driver',
    'ED007 - K.R.Herath',
    'ED0011 - W.D.Karunarathne',
    'ED0019 - N.L.Bandara'
  ];
  List<String> ordersData = [];
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  List<String> orders = [];

  String selectedDriver = "Select Driver", selectedOrder = "Select Order";

  Future<List<String>> orderList() async {
    List<String> order = ['Select Order'];

    QuerySnapshot<Map<String, dynamic>> querySnapshot;
    querySnapshot = await firestore.collection('approveOrder').get();

    querySnapshot.docs.forEach((doc) {
      order.add(doc['orderid']);
    });

    return order;
  }

  Future<void> _loadOrders() async {
    List<String> data = await orderList();
    setState(() {
      orders = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Assign Driver'),
          backgroundColor: Colors.grey[900],
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                    child: Form(
                  key: _formKey,
                  child: Column(children: [
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      // Makes the container and DropdownButton full width
                      child: DropdownButtonFormField<String>(
                        value: selectedDriver,
                        onChanged: (String? selected) {
                          if (selected == "Select Driver") {
                            return;
                          } else {
                            this.setState(() {
                              selectedDriver = selected!;
                            });
                          }
                        },
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value == "Select Driver") {
                            return 'Please Select Driver Name';
                          }
                          return null;
                        },
                        items: driver
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Select Driver',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      // Makes the container and DropdownButton full width
                      child: DropdownButtonFormField<String>(
                        value: selectedOrder,
                        onChanged: (String? selected) {
                          if (selected == "Select Order") {
                            return;
                          } else {
                            this.setState(() {
                              selectedOrder = selected!;
                            });
                          }
                        },
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value == "Select Order") {
                            return 'Please Select Order';
                          }
                          return null;
                        },
                        items: orders.map((data) {
                          return DropdownMenuItem(
                            value: data,
                            child: Text(data),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Select Order',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      width: 200,
                      height: 55,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 6, 39, 52)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (selectedDriver != "") {
                              if (selectedOrder != "") {
                                try {
                                  await firestore
                                      .collection("drivers")
                                      .doc()
                                      .set({
                                    'driver': selectedDriver,
                                    'order': selectedOrder,
                                  });
                                  this.setState(() {
                                    selectedDriver = "Select Driver";
                                    selectedOrder = "Select Order";
                                  });
                                  Fluttertoast.showToast(msg: "success");
                                } catch (e) {
                                  print(e);
                                }
                              } else {
                                Fluttertoast.showToast(msg: "select order");
                              }
                            } else {
                              Fluttertoast.showToast(msg: "select driver");
                            }
                          }
                        },
                        child: Text('Place Order'),
                      ),
                    ),
                    SizedBox(height: 30),
                  ]),
                )))));
  }
}
