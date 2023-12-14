import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:constro/views/delivery/AdminOrderList.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'OrderList.dart';

class AdminEditOrder extends StatefulWidget {
  final String receivedQuantity, sendQuantity, id;

  AdminEditOrder(
      {required this.sendQuantity,
      required this.receivedQuantity,
      required this.id})
      : super();

  @override
  _AdminEditOrderState createState() => _AdminEditOrderState();
}

class _AdminEditOrderState extends State<AdminEditOrder> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController quantityController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    quantityController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    quantityController.text = widget.sendQuantity;
  }

  void update(String quantity) {
    firestore.collection('approveOrder').doc(widget.id).update({
      'sendQuantity': quantity,
    });
    Fluttertoast.showToast(msg: "Successfully Updated");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdminOrderList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Update Order Quantity'),
          backgroundColor: Colors.grey[900],
        ),
        body: SingleChildScrollView(
            child: Container(
                child: Form(
                    key: _formKey,
                    child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            SizedBox(height: 30),
                            Text('Update Send Order Quantity',
                                style: TextStyle(
                                  fontWeight:
                                      FontWeight.bold, // Making text bold
                                  fontSize:
                                      24, // Setting text size to 18 pixels
                                )),
                            SizedBox(height: 30),
                            Container(
                              width: double.infinity,
                              // Makes the container and DropdownButton full width
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                maxLines: 1,
                                style: TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.list_alt),
                                  hintText: 'Quantity',
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                ),
                                controller: quantityController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Quantity';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 20.0),
                            SizedBox(
                                width: double.infinity,
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
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      update(quantityController.text);
                                    }
                                  },
                                  child: const Text('Update'),
                                )),
                          ],
                        ))))));
  }
}
