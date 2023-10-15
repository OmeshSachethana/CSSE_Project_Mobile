import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart'; // import the CartModel

class ProductsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartModel>(context); // get the CartModel
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return ListTile(
              title: Text(data['name']),
              subtitle: Text(data['description']),
              leading: Image.network(data['imageUrl']),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("\$${data['price'].toString()}"),
                  IconButton(
                    icon: Icon(Icons.add_shopping_cart),
                    onPressed: () {
                      cart.addProduct(data); // add the product to the cart
                    },
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
