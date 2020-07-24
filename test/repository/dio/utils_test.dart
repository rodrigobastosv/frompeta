import 'package:flutter_test/flutter_test.dart';
import 'package:flutterdryve/repository/dio/utils.dart';

void main() async {
  test('getDefaultClient()', () {
    final dio = getDefaultClient();
    expect(dio.options.baseUrl, 'https://run.mocky.io/v3/');
  });
}
