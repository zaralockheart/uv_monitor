import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:uv_assessment/generated/l10n.dart';
import 'package:uv_assessment/widget/login.dart';
import 'package:google_fonts/google_fonts.dart';

import 'res/color.dart';

void main() {

  DotEnv().env['UV_TOKEN'] = '707a11d9393a5719b0ddd0fb9c3ba7b8';
  DotEnv().env['UV_URL'] = 'https://api.openuv.io/api/v1/uv';

  runApp(MyApp(
    home: Login(),
  ));
}

/// Entry point for application / Widget test.
class MyApp extends StatelessWidget {
  const MyApp({Key key, @required this.home}) : super(key: key);

  /// Widget to be rendered for first screen.

  final Widget home;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          scaffoldBackgroundColor: backgroundColor,
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
            headline3: GoogleFonts.poppins(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
            ),
            headline6: GoogleFonts.poppins(),
          ),
          buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 12,
            ),
          )),
      localizationsDelegates: [S.delegate],
      supportedLocales: S.delegate.supportedLocales,
      home: home,
    );
  }
}
