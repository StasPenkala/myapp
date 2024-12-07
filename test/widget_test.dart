// ignore_for_file: unused_import

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:myapp/main.dart';


void main() {
  testWidgets('Calculator UI Test', (WidgetTester tester) async {
    // Build the Calculator App
    await tester.pumpWidget(CalculatorApp());

    // Verify initial output
    expect(find.text('0'), findsOneWidget);

    // Press '7' button
    await tester.tap(find.text('7'));
    await tester.pump();

    // Verify updated output
    expect(find.text('7'), findsOneWidget);

    // Press '+' button
    await tester.tap(find.text('+'));
    await tester.pump();

    // Verify operand
    await tester.tap(find.text('3'));
    await tester.pump();

    // Verify '=' button
    await tester.tap(find.text('='));
    await tester.pump();

    // Check final result
    expect(find.text('10.0'), findsOneWidget);
  });
}
