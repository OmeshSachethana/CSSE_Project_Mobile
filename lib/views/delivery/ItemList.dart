import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';

class ItemList extends StatefulWidget {
  final String data;

  ItemList({required this.data}) : super();

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  List item = [];

  @override
  void initState() {
    super.initState();
    this.setState(() {
      item = json.decode(widget.data).cast<String>();
    });
    print(item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Item List'),
          backgroundColor: Colors.grey[900],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                    final itemData = item[index];
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
                      onDismissed: (direction) {},
                      child: Card(
                        elevation: 10,
                        color: Colors.white,
                        child: ListTile(
                          minLeadingWidth: 2,
                          leading: Image.asset(
                            'assets/images/itemIco.png',
                            height: 120,
                          ),
                          title: Text(
                            'Item Date : ${itemData['date']}',
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
                                'Item Price: ${itemData['totalPrice']}',
                                style: TextStyle(
                                    fontSize: 13.0, color: Colors.black),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                'Item status: ${itemData['approveStatus']}',
                                style: TextStyle(
                                    fontSize: 13.0, color: Colors.black),
                              ),
                              SizedBox(height: 5.0),
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
