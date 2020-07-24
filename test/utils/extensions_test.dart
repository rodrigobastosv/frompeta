import 'package:flutter_test/flutter_test.dart';
import 'package:flutterdryve/utils/extensions.dart';

void main() async {
  test('capitalize', () {
    expect('aaa'.capitalize(), 'Aaa');
    expect('Aaa'.capitalize(), 'Aaa');
    expect('AAA'.capitalize(), 'Aaa');
  });
}
