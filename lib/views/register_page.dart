import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  //Register now
  final Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Add this function to check password requirements
  bool isPasswordValid(String password) {
    // Define a regular expression for password validation
    RegExp passwordRegExp =
        RegExp(r'^(?=.*?[A-Za-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    return passwordRegExp.hasMatch(password);
  }

  //sign user in method
  void signUserUp() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    if (passwordController.text != confirmPasswordController.text) {
      if (context.mounted) {
        Navigator.pop(context);
      }
      showErrorMessage("Passwords don't match!");
      return;
    }

    if (!isPasswordValid(passwordController.text)) {
      if (context.mounted) {
        Navigator.pop(context);
      }
      showErrorMessage(
          "Password must have at least one special character and one number.");
      return;
    }

    try {
      //create the user
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      //after creating the user
      FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user!.uid)
          .set({
        'username': emailController.text.split('@')[0],
        'contactNumber': '0771234567',
        'age': '0',
        'address': 'address',
        'city': 'city',
        'profileImageURL': '',
      });

      if (context.mounted) {
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
      }
      showErrorMessage(e.code);
    }
  }

  //Error message to user
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          backgroundColor: Colors.deepPurple,
          title: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 225, 244, 248),
      body: SafeArea(
        //avoid the top notch touch
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 15),

                //app name
                const Text(
                  'C O N S T R O',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(
                  Icons.lock,
                  size: 100,
                  color: Color.fromARGB(255, 48, 48, 132),
                ),
                const SizedBox(height: 0),
                Text(
                  'Create an account!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 15),

                //username textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                //password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                //password textfield
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Re-enter Password',
                  obscureText: true,
                ),
                const SizedBox(height: 25),

                //sign in button
                MyButton(text: "Sign Up", onTap: signUserUp),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login Now',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
