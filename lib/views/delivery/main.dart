import 'dart:convert';
import 'dart:io';

import 'package:constro/views/delivery/user.dart';
import 'package:flutter/material.dart';
import 'drivers.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Main Page'),
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
                  backgroundColor: MaterialStateProperty.all(Colors.purple),
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
                      builder: (context) => Drivers(),
                    ),
                  );
                },
                child: Text('Admin'),
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: 200,
              height: 55,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.purple),
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
                      builder: (context) => Users(),
                    ),
                  );
                },
                child: Text('User'),
              ),
            ),
            SizedBox(height: 30),
          ]),
        )));
  }
}
