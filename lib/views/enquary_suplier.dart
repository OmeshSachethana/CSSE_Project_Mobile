import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EnquiryForm extends StatefulWidget {
  @override
  _EnquiryFormState createState() => _EnquiryFormState();
}

class _EnquiryFormState extends State<EnquiryForm> {
  final _formKey = GlobalKey<FormState>();
  String orderId = '';
  String productName = '';
  String reason = '';

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, save the enquiry to Firestore
      FirebaseFirestore.instance.collection('enquirySupplier').add({
        'orderId': orderId,
        'productName': productName,
        'reason': reason,
      }).then((value) {
        // Enquiry saved successfully
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Enquiry Submitted'),
              content: Text('Your enquiry has been submitted.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );

        // Clear the form fields
        setState(() {
          orderId = '';
          productName = '';
          reason = '';
        });
      }).catchError((error) {
        // Handle error
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('An error occurred: $error'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enquiry Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Order ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the order ID';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    orderId = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Product Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product name';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    productName = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Reason for Enquiry'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the reason for your enquiry';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    reason = value;
                  });
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: submitForm,
                child: Text('Submit Enquiry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
