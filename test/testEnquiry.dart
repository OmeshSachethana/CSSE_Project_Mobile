import 'package:constro/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  testWidgets('Create a new enquiry in enquiriesFrom widget',
      (WidgetTester tester) async {
    // Build your widget
    await tester.pumpWidget(
        const MyApp()); // Replace 'MyApp' with your app's entry point.

    // Find the 'Create new project' button and tap it
    final createButtonFinder = find.byIcon(Icons.add);
    await tester.tap(createButtonFinder);
    await tester.pump();

    // Verify that the Enquiry Form modal appears
    expect(find.text("Enquiry Form"), findsOneWidget);

    // Enter data into the text fields and submit
    final orderidField = find.byType(TextField).at(0);
    final itemnameField = find.byType(TextField).at(1);
    final reasonField = find.byType(TextField).at(2);
    final snField = find.byType(TextField).at(3);
    final createButton = find.text("Create");

    await tester.enterText(orderidField, "Test Order");
    await tester.enterText(itemnameField, "Test Item");
    await tester.enterText(reasonField, "Test Reason");
    await tester.enterText(snField, "123");

    await tester.tap(createButton);
    await tester.pump();

    // Verify that the new enquiry is added to Firestore
    final firestore = FirebaseFirestore.instance;
    final querySnapshot = await firestore
        .collection('enquiries')
        .where("orderid", isEqualTo: "Test Order")
        .get();

    expect(querySnapshot.docs.isNotEmpty, true);

    // Verify that the Enquiry Form modal is closed
    expect(find.text("Enquiry Form"), findsNothing);
  });
}
