import 'package:constro/views/delivery/drivers.dart';
import 'package:constro/views/delivery/user.dart';
import 'package:constro/views/product_cart_view.dart';
import 'package:constro/views/products_view.dart'; // import the ProductsView
import 'package:constro/views/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  //sign out user
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  void navigateToCartPage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProductCartView()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(
            onPressed: () => navigateToCartPage(context),
            icon: const Icon(Icons.shopping_cart),
          ),
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(Icons.logout),
          )
        ],
      ),

      //-----------------------------------------------------------------
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 149, 156, 162),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 120, // Adjust the height as needed
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 6, 39, 52),
              ),
              child: const Center(
                child: Text(
                  'M E N U',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ListTile(
              title: const Text('S U P P L I E R',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Drivers(),
                  ),
                );
                // Add your logic for when Item 1 is tapped
                //goToProfilePage(context);
              },
            ),
            ListTile(
              title: const Text('S I T E  M A N A G E R',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Users(),
                    ));
              },
            ), // Users()
            ListTile(
              title: const Text('P R O F I L E',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProfilePage(),
                    ));
              },
            ),

            const SizedBox(height: 180),
            ListTile(
              title: const Text('L O G O U T',
                  style: TextStyle(color: Colors.white)),
              onTap: signUserOut,
            ),
            // Add more ListTile items as needed
          ],
        ),
      ),

      //-----------------------------------------------------------------

      body: ProductsView(), // call the ProductsView here
    );
  }
}
