import 'package:constro/views/product_cart_view.dart';
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
      body: Center(child: Text("Logged In as " + user.email!)),
    );
  }
}
