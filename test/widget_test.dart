// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uv_assessment/widget/widget.dart';

import 'utilities.dart';

void main() {
  testWidgets('Test Login screen UI', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(Login()));

    await tester.pump();

    expect(find.text('Sign in with Google'), findsOneWidget);
    expect(find.text('UV Monitor'), findsOneWidget);
  });

  testWidgets('Test UV Monitor text spec', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(Login()));

    await tester.pump();

    // Criteria: from Figma
    // position: absolute; # Ignore
    // width: 271px; # Dynamically follow Text
    // height: 40px; # Dynamically follow Text
    // left: 52px; # Dynamically follow Text
    // TODO(Yuzuriha): Verify this with Enlightyx
    // top: 343px; # Everything should start from center?
    //
    // font-family: Poppins;
    // font-style: normal;
    // font-weight: 500;
    // font-size: 36px;
    // line-height: 54px;
    // text-align: center;

    final text = find.text('UV Monitor').evaluate().single.widget as Text;

    // font-family: Poppins;
    expect(text.style.fontFamily.toLowerCase().contains('poppins'), true);

    // font-style: normal;
    expect(text.style.fontStyle, FontStyle.normal);

    // font-weight: 500;
    expect(text.style.fontWeight, FontWeight.w500);

    // font-size: 36px;
    expect(text.style.fontSize, 36);

    // text-align: center;
    expect(text.textAlign, TextAlign.center);

    // color: #FC5B00;
    expect(text.style.color, const Color(0xFFFC5B00));
  });

  testWidgets('Test Sign In Button', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(Login()));

    await tester.pump();

    // Criteria: from Figma
    // position: absolute; # Ignore
    // width: 215px; # Dynamically follow Children
    // height: 60px; # Dynamically follow Children
    // left: 86px; # Dynamically follow Children
    // TODO(Yuzuriha): Verify this with Enlightyx
    // top: 434px; # Everything should start from center?
    //
    // background: #0E7BE0;
    // border-radius: 8px;

    final Finder rawButtonMaterial = find.descendant(
      of: find.byKey(const Key('sign in button')),
      matching: find.byType(Material),
    );

    final signInButton = tester.widget<Material>(rawButtonMaterial);

    // background: #0E7BE0;
    expect(signInButton.color, const Color(0xFF0E7BE0));

    // border-radius: 8px;
    expect(
      signInButton.shape,
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  });
}
