import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AssignDriver extends StatefulWidget {
  final List<String> drivers; // List of available drivers

  AssignDriver({required this.drivers});

  @override
  _AssignDriverState createState() => _AssignDriverState();
}

class _AssignDriverState extends State<AssignDriver> {
  String selectedDriver = ''; // The selected driver
  late TextEditingController locationController;

  @override
  void initState() {
    super.initState();
    locationController = TextEditingController();
  }

  @override
  void dispose() {
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assign Driver'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            DropdownButtonFormField(
              items: widget.drivers.map((driver) {
                return DropdownMenuItem(
                  value: driver,
                  child: Text(driver),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedDriver = value as String;
                });
              },
              value: selectedDriver,
              decoration: InputDecoration(labelText: 'Select Driver'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: locationController,
              decoration: InputDecoration(labelText: 'Enter Location'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                //assignDriver(selectedDriver, locationController.text);
              },
              child: Text('Assign Driver'),
            ),
          ],
        ),
      ),
    );
  }

  void assignDriver(String orderId, String driver, String location) {
    FirebaseFirestore.instance.collection('orders').doc(orderId).update({
      'assignedDriver': driver,
      'deliveryLocation': location,
    }).then((_) {
      // Successful assignment
      showConfirmationDialog(
          'Driver Assigned', 'The driver has been assigned to the order.');
    }).catchError((error) {
      // Handle error, e.g., display an error message
      showConfirmationDialog(
          'Error', 'An error occurred while assigning the driver: $error');
    });
  }

  void showConfirmationDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // You can navigate back to the order details screen or perform other actions here.
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
