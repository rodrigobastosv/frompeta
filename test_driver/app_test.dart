import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Flutter Driver tests', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });

    test('check flutter driver health', () async {
      final health = await driver.checkHealth();
      print(health.status);
    });

    test('should land on CarsFeedPage', () async {
      expect(driver.waitFor(find.byType('CarsFeedPage')), completes);
    });
  });
}
