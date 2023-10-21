import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart'; // import the CartModel

class ProductsView extends StatefulWidget {
  @override
  _ProductsViewState createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  String searchText = ''; // To store the search text

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

        // Filter the products based on the search text
        final filteredProducts = snapshot.data!.docs.where((product) {
          final data = product.data() as Map<String, dynamic>;
          return data['name'].toLowerCase().contains(searchText.toLowerCase());
        }).toList();

        return Column(
          children: <Widget>[
            // Search bar
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search for products...',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // You can change this value as needed
                  childAspectRatio:
                      0.7, // Adjust this for the desired aspect ratio
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data =
                      filteredProducts[index].data() as Map<String, dynamic>;
                  return Card(
                    elevation: 4, // Add a drop shadow
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12.0), // Add rounded corners
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.all(8.0), // Add padding to the card
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 120, // Adjust the image height
                            width: double.infinity,
                            child: Image.network(data['imageUrl']),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(data['name'],
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(data['description']),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("\$${data['price'].toString()}"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 0.0,
                                right: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .end,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    cart.addProduct(
                                        data);
                                  },
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: const BoxDecoration(
                                     color: Color.fromARGB(255, 13, 82, 109),
                                      shape:
                                          BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.add_shopping_cart,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
