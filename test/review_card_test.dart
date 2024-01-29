import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/widget/custom/review_card.dart';

void main() {
  testWidgets('ReviewCard widget test', (WidgetTester tester) async {
    // Create a mock review for testing
    final Map<String, dynamic> testReview = {
      'name': 'John Doe',
      'date': '2024-01-29',
      'review': 'This is a test review.',
    };

    // Build our widget and trigger a frame
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ReviewCard(review: testReview),
        ),
      ),
    );

    // Verify that the ReviewCard is rendered with the correct information
    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('2024-01-29'), findsOneWidget);
    expect(find.text('This is a test review.'), findsOneWidget);
  });
}
