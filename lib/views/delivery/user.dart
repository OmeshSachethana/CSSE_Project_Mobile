import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'DriverList.dart';
import 'OrderList.dart';

class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Site Manager Dashboard'),
          backgroundColor: Colors.grey[900],
        ),
        body: SingleChildScrollView(
            child: Center(
          child: Column(children: [
            SizedBox(height: 35),
            SizedBox(
              width: 200,
              height: 55,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Color.fromARGB(255, 6, 39, 52)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderList(),
                    ),
                  );
                },
                child: Text('Order List'),
              ),
            ),
            SizedBox(height: 30),
          ]),
        )));
  }
}
