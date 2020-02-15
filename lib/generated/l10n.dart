// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

class S {
  S(this.localeName);
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return S(localeName);
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  final String localeName;

  String get _locale {
    return Intl.message(
      'en',
      name: '_locale',
      desc: '',
      args: [],
    );
  }

  String get appTitle {
    return Intl.message(
      'UV Monitor',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  String get signInGoogle {
    return Intl.message(
      'Sign in with Google',
      name: 'signInGoogle',
      desc: '',
      args: [],
    );
  }

  String get uvIndex {
    return Intl.message(
      'UV index',
      name: 'uvIndex',
      desc: '',
      args: [],
    );
  }

  String get refresh {
    return Intl.message(
      'Refresh',
      name: 'refresh',
      desc: '',
      args: [],
    );
  }

  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  String get fetching {
    return Intl.message(
      'Fetching...',
      name: 'fetching',
      desc: '',
      args: [],
    );
  }

  String get noLocation {
    return Intl.message(
      'No Location detected',
      name: 'noLocation',
      desc: '',
      args: [],
    );
  }

  String latitude(dynamic latitude) {
    return Intl.message(
      'Latitude: $latitude',
      name: 'latitude',
      desc: '',
      args: [latitude],
    );
  }

  String longitude(dynamic longitude) {
    return Intl.message(
      'Longitude: $longitude',
      name: 'longitude',
      desc: '',
      args: [longitude],
    );
  }

  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale('en', 'US'), Locale('en', ''),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (Locale supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}