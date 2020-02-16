import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/mockito.dart';
import 'package:uv_assessment/bloc/bloc.dart';
import 'package:uv_assessment/utils/utils.dart';
import 'package:uv_assessment/model/model.dart';
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

  group('Test Home page', () {
    UvMonitorBloc bloc;
    RetrofitMock client;
    LibWrapperMock wrapper;

    setUpAll(() {
      client = RetrofitMock();

      wrapper = LibWrapperMock();
      when(wrapper.checkPermission()).thenAnswer(
        (_) => Future.value(GeolocationStatus.granted),
      );

      when(wrapper.getCurrentLocation()).thenAnswer(
        (realInvocation) => Future.value(
          Position(
            latitude: 10.1,
            longitude: 20.1,
          ),
        ),
      );

      const mockResponse = UvIndex(
        result: Result(uvMax: 1000.101),
      );

      final now = DateTime.now().ignoreSecond();

      when(client.getUv(10.1, 20.1, now.toIso8601String())).thenAnswer(
        (_) => Future.value(
          mockResponse,
        ),
      );
    });

    testWidgets('Test Home screen top screen', (WidgetTester tester) async {
      bloc = UvMonitorBloc(client, wrapper: wrapper);

      // Build our app and trigger a frame.
      await tester.pumpWidget(makeTestableWidget(BlocProvider<UvMonitorBloc>(
        create: (_) => bloc,
        child: TopScreen(),
      )));

      await tester.pump();

      bloc.add(FetchUvData());
      bloc.add(UpdateTime(currentTime: DateTime(2017, 5, 30, 10, 40, 30)));

      await tester.pumpAndSettle();

      expect(find.text('1000.101'), findsOneWidget);

      expect(find.text('May 30, 10:40 AM'), findsOneWidget);

      expect(find.text('UV index'), findsOneWidget);
    });

    testWidgets('Test UV amount text spec', (WidgetTester tester) async {
      bloc = UvMonitorBloc(client, wrapper: wrapper);

      // Build our app and trigger a frame.
      await tester.pumpWidget(makeTestableWidget(BlocProvider<UvMonitorBloc>(
        create: (_) => bloc,
        child: TopScreen(),
      )));

      await tester.pump();

      // Criteria from Figma
      // font-family: Poppins;
      // font-style: normal;
      // font-weight: 500;
      // font-size: 64px;
      // line-height: 96px;
      // display: flex;
      // align-items: center;
      // text-align: center;
      //
      // color: #302EAE;

      final uvText = find.byKey(const Key('uv index'));
      expect(uvText, findsOneWidget);

      final text = uvText.evaluate().single.widget as Text;

      // font-family: Poppins;
      expect(text.style.fontFamily.toLowerCase().contains('poppins'), true);

      // font-style: normal;
      expect(text.style.fontStyle, FontStyle.normal);

      // font-weight: 500;
      expect(text.style.fontWeight, FontWeight.w500);

      // font-size: 64px;
      expect(text.style.fontSize, 64);

      // Not too sure on
      // line-height: 96px;
      // TODO(Yusuf): Discuss with team.

      // text-align: center;
      expect(text.textAlign, TextAlign.center);

      // color: #302EAE;
      expect(text.style.color, const Color(0xFF302EAE));
    });

    testWidgets('Test UV index text', (WidgetTester tester) async {
      bloc = UvMonitorBloc(client, wrapper: wrapper);

      // Build our app and trigger a frame.
      await tester.pumpWidget(makeTestableWidget(BlocProvider<UvMonitorBloc>(
        create: (_) => bloc,
        child: TopScreen(),
      )));

      await tester.pump();

      // Criteria from Figma
      // font-family: Poppins;
      // font-style: normal;
      // font-weight: 500;
      // font-size: 36px;
      // line-height: 54px;
      // display: flex;
      // align-items: center;
      // text-align: center;
      //
      // color: #676767;

      final uvText = find.text('UV index');
      expect(uvText, findsOneWidget);

      final text = uvText.evaluate().single.widget as Text;

      // font-family: Poppins;
      expect(text.style.fontFamily.toLowerCase().contains('poppins'), true);

      // font-style: normal;
      expect(text.style.fontStyle, FontStyle.normal);

      // font-weight: 500;
      expect(text.style.fontWeight, FontWeight.w500);

      // font-size: 36px;
      expect(text.style.fontSize, 36);

      // Not too sure on
      // line-height: 54px;
      // TODO(Yusuf): Discuss with team.

      // text-align: center;
      expect(text.textAlign, TextAlign.center);

      // color: #676767;
      expect(text.style.color, const Color(0xFF676767));
    });

    testWidgets('Test time text', (WidgetTester tester) async {
      bloc = UvMonitorBloc(client, wrapper: wrapper);

      // Build our app and trigger a frame.
      await tester.pumpWidget(makeTestableWidget(BlocProvider<UvMonitorBloc>(
        create: (_) => bloc,
        child: TopScreen(),
      )));

      await tester.pump();

      // Criteria from Figma
      // font-family: Poppins;
      // font-style: normal;
      // font-weight: 300;
      // font-size: 18px;
      // line-height: 27px;
      // display: flex;
      // align-items: center;
      // text-align: center;
      //
      // color: #676767;

      final uvText = find.byKey(const Key('time'));
      expect(uvText, findsOneWidget);

      final text = uvText.evaluate().single.widget as Text;

      // font-family: Poppins;
      expect(text.style.fontFamily.toLowerCase().contains('poppins'), true);

      // font-style: normal;
      expect(text.style.fontStyle, FontStyle.normal);

      // font-weight: 300;
      expect(text.style.fontWeight, FontWeight.w300);

      // font-size: 18px;
      expect(text.style.fontSize, 18);

      // Not too sure on
      // line-height: 27px;
      // TODO(Yusuf): Discuss with team.

      // text-align: center;
      expect(text.textAlign, TextAlign.center);

      // color: #676767;
      expect(text.style.color, const Color(0xFF676767));
    });

    testWidgets('Test Home page bottom', (WidgetTester tester) async {
      bloc = UvMonitorBloc(client, wrapper: wrapper);

      // Build our app and trigger a frame.
      await tester.pumpWidget(makeTestableWidget(BlocProvider<UvMonitorBloc>(
        create: (_) => bloc,
        child: BottomScreen(),
      )));

      await tester.pump();

      bloc.add(UpdateLocation(
          location: Position(
        latitude: 31.98,
        longitude: 101.31,
      )));

      await tester.pumpAndSettle();

      expect(find.text('Refresh'), findsOneWidget);
      expect(find.text('Logout'), findsOneWidget);
      expect(find.text('Latitude: 31.98'), findsOneWidget);
      expect(find.text('Longitude: 101.31'), findsOneWidget);
    });

    testWidgets('Test Latitude / Longitude UI', (WidgetTester tester) async {
      bloc = UvMonitorBloc(client, wrapper: wrapper);

      // Build our app and trigger a frame.
      await tester.pumpWidget(makeTestableWidget(BlocProvider<UvMonitorBloc>(
        create: (_) => bloc,
        child: BottomScreen(),
      )));

      await tester.pump();

      bloc.add(
        UpdateLocation(
          location: Position(
            latitude: 31.98,
            longitude: 101.31,
          ),
        ),
      );

      // Both criteria are same

      // Criteria from Figma
      // font-family: Poppins;
      // font-style: normal;
      // font-weight: 500;
      // font-size: 18px;
      // line-height: 27px;
      //
      // display: flex;
      // align-items: center;
      // text-align: center;
      //
      // color: #FFFFFF;

      await tester.pumpAndSettle();

      final latitudeFinder = find.byKey(const Key('latitude'));
      final longitudeFinder = find.byKey(const Key('longitude'));

      expect(latitudeFinder, findsOneWidget);
      expect(longitudeFinder, findsOneWidget);

      final latitudeText = latitudeFinder.evaluate().single.widget as Text;
      final longitudeText = longitudeFinder.evaluate().single.widget as Text;

      // font-family: Poppins;
      expect(latitudeText.style.fontFamily.toLowerCase().contains('poppins'), true);
      expect(longitudeText.style.fontFamily.toLowerCase().contains('poppins'), true);

      // font-style: normal;
      expect(latitudeText.style.fontStyle, FontStyle.normal);
      expect(longitudeText.style.fontStyle, FontStyle.normal);

      // font-weight: 500;
      expect(latitudeText.style.fontWeight, FontWeight.w500);
      expect(longitudeText.style.fontWeight, FontWeight.w500);

      // font-size: 18px;
      expect(latitudeText.style.fontSize, 18);
      expect(longitudeText.style.fontSize, 18);

      // Not too sure on
      // line-height: 27px;
      // TODO(Yusuf): Discuss with team.

      // text-align: center;
      expect(latitudeText.textAlign, TextAlign.center);
      expect(longitudeText.textAlign, TextAlign.center);

      // color: #FFFFFF;
      expect(latitudeText.style.color, const Color(0xFFFFFFFF));
      expect(longitudeText.style.color, const Color(0xFFFFFFFF));
    });

    testWidgets('Test Refresh / Logout text', (WidgetTester tester) async {
      bloc = UvMonitorBloc(client, wrapper: wrapper);

      // Build our app and trigger a frame.
      await tester.pumpWidget(makeTestableWidget(BlocProvider<UvMonitorBloc>(
        create: (_) => bloc,
        child: BottomScreen(),
      )));

      await tester.pump();

      bloc.add(
        UpdateLocation(
          location: Position(
            latitude: 31.98,
            longitude: 101.31,
          ),
        ),
      );

      // Both criteria are same

      // Criteria from Figma
      // font-family: Poppins;
      // font-style: normal;
      // font-weight: 500;
      // font-size: 18px;
      // line-height: 27px;
      // display: flex;
      // align-items: center;
      // text-align: center;
      //
      // color: #FFFFFF;

      await tester.pumpAndSettle();

      final refresh = find.text('Refresh');
      final logout = find.text('Logout');

      expect(refresh, findsOneWidget);
      expect(logout, findsOneWidget);

      final refreshText = refresh.evaluate().single.widget as Text;
      final logoutText = logout.evaluate().single.widget as Text;

      // font-family: Poppins;
      expect(refreshText.style.fontFamily.toLowerCase().contains('poppins'), true);
      expect(logoutText.style.fontFamily.toLowerCase().contains('poppins'), true);

      // font-style: normal;
      expect(refreshText.style.fontStyle, FontStyle.normal);
      expect(logoutText.style.fontStyle, FontStyle.normal);

      // font-weight: 500;
      expect(refreshText.style.fontWeight, FontWeight.w500);
      expect(logoutText.style.fontWeight, FontWeight.w500);

      // font-size: 18px;
      expect(refreshText.style.fontSize, 18);
      expect(logoutText.style.fontSize, 18);

      // Not too sure on
      // line-height: 27px;
      // TODO(Yusuf): Discuss with team.

      // text-align: center;
      expect(refreshText.textAlign, TextAlign.center);
      expect(logoutText.textAlign, TextAlign.center);

      // color: #FFFFFF;
      expect(refreshText.style.color, const Color(0xFFFFFFFF));
      expect(logoutText.style.color, const Color(0xFFFFFFFF));
    });
  });
}
