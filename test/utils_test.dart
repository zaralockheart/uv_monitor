import 'package:flutter_test/flutter_test.dart';
import 'package:uv_assessment/utils/utils.dart';

void main() {
  test('Test date format to use UI format', () {
    final date = DateTime(2017, 10, 21, 23, 51, 34);

    expect(date.reFormat(), 'Oct 21, 11:51 PM');
  });

  test('Test date format', () {
    // Date format UI Oct 21m 11:51 PM
    final date = DateTime(2017, 10, 21, 23, 51, 34);

    expect(date.reFormat().contains(','), true);
    expect(date.reFormat().contains(':'), true);
    expect(date.reFormat().contains(' '), true);
    expect(date.reFormat().contains(' '), true);
    expect(date.reFormat().contains('Oct'), true);
    expect(date.reFormat().contains('21,'), true);
    expect(date.reFormat().contains('11:51'), true);
    expect(date.reFormat().contains('PM'), true);
  });
}
