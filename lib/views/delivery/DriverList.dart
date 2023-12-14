import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';

class DriverList extends StatefulWidget {
  @override
  _DriverListState createState() => _DriverListState();
}

class _DriverListState extends State<DriverList> {
  List driver = [];
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String selectedDriver = "";

  Future<List?> driverList() async {
    QuerySnapshot querySnapshot;
    List list = [];
    try {
      querySnapshot = await firestore.collection('drivers').get();

      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          print(doc.id);
          Map map = {
            "id": doc.id,
            "driver": doc['driver'],
            "order": doc['order'],
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
    this.driverList().then((value) => {
          setState(() {
            driver = value!;
          }),
          print(value)
        });
  }

  void delete(String id) {
    firestore.collection('drivers').doc(id).delete();
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => super.widget));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Delivery List'),
          backgroundColor: Colors.grey[900],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: driver.length,
                  itemBuilder: (context, index) {
                    final driverData = driver[index];
                    return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Color.fromARGB(255, 83, 72, 71),
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
                        delete(driverData['id'].toString());
                      },
                      child: Card(
                        elevation: 10,
                        color: Colors.white,
                        child: ListTile(
                          minLeadingWidth: 2,
                          leading: Image.asset(
                            'assets/images/driver2.jpg',
                            height: 120,
                          ),
                          title: Text(
                            'Driver Name : ${driverData['driver']}',
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
                                'Order : ${driverData['order']}',
                                style: TextStyle(
                                    fontSize: 13.0, color: Colors.black),
                              ),
                              SizedBox(height: 5.0),
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(width: 100.0),
                                    ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color.fromARGB(
                                                      255, 6, 39, 52)),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          delete(driverData['id'].toString());
                                        },
                                        child: Text('Delete')),
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
