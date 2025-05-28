import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:read_more_codespark/read_more_codespark.dart';

void main() {
  testWidgets('ReadMoreCodeSpark expands and collapses text',
      (WidgetTester tester) async {
    const testText =
        'This is a test text that should be truncated and then expanded.';

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SimpleReadMoreText(
            text: testText,
            trimLines: 1,
          ),
        ),
      ),
    );

    // Verify that the "Read more" text is present
    expect(find.text('Read more'), findsOneWidget);

    // Tap on "Read more"
    await tester.tap(find.text('Read more'));
    await tester.pumpAndSettle();

    // Verify that the "Read less" text is present
    expect(find.text('Read less'), findsOneWidget);
  });
}
