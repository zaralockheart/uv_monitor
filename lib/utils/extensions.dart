import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uv_assessment/generated/l10n.dart';

extension MyContext on BuildContext {
  Future<T> push<T>({
    @required Widget target,
    @required String name,
  }) => Navigator.push(
    this,
    MaterialPageRoute(
        builder: (context) => target,
        settings: RouteSettings(name: name)),
  );

  S get locale => S.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension MyDateTime on DateTime {
  String reFormat() {
    if (this == null) {
      return '';
    }
    return DateFormat('MMM dd, hh:mm aa').format(this);
  }

  DateTime ignoreSecond() {
    if (this == null) {
      return null;
    }
    return DateTime(year, month, day, hour, minute, second);
  }
}
