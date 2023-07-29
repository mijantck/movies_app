import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/utils/AppColors.dart';
import 'package:movies_app/views/widgets/GenreItem.dart';

void main() {
  testWidgets('GenreItem - selected', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: GenreItem(true, 'Comedy'),
      ),
    ));

    // Find the container widget and verify its decoration.
    final container = find.byType(Container);
    expect(container, findsOneWidget);
    final decoratedContainer = tester.widget<Container>(container);
    expect(decoratedContainer.decoration, BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: AppColors.black,
        width: 1,
      ),
      color: AppColors.black,
    ));

    // Find the text widget and verify its style.
    final text = find.text('Comedy');
    expect(text, findsOneWidget);
    final textStyle = tester.widget<Text>(text).style;
    expect(textStyle?.color, Colors.white);
    expect(textStyle?.fontFamily, 'Inter');
    expect(textStyle?.fontWeight, FontWeight.w500);
    expect(textStyle?.fontSize, 14);
  });

  testWidgets('GenreItem - not selected', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: GenreItem(false, 'Comedy'),
      ),
    ));

    // Find the container widget and verify its decoration.
    final container = find.byType(Container);
    expect(container, findsOneWidget);
    final decoratedContainer = tester.widget<Container>(container);
    expect(decoratedContainer.decoration, BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: AppColors.gray_item_border,
        width: 1,
      ),
      color: AppColors.white,
    ));

    // Find the text widget and verify its style.
    final text = find.text('Comedy');
    expect(text, findsOneWidget);
    final textStyle = tester.widget<Text>(text).style;
    expect(textStyle?.color, Colors.black);
    expect(textStyle?.fontFamily, 'Inter');
    expect(textStyle?.fontWeight, FontWeight.w500);
    expect(textStyle?.fontSize, 14);
  });
}
