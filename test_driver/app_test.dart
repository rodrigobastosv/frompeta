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
      await Future.delayed(const Duration(seconds: 3));
    });

    test('should open settings', () async {
      expect(driver.waitFor(find.byType('SettingsButton')), completes);
      await driver.tap(find.byType('SettingsButton'));
      await Future.delayed(const Duration(seconds: 1));
    });

    test('should pick a brand and increment filters count', () async {
      await driver.tap(find.byValueKey('1'));
      await Future.delayed(const Duration(seconds: 1));
      expect(driver.waitFor(find.text('1')), completes);
      await driver.tap(find.byValueKey('2'));
      await Future.delayed(const Duration(seconds: 1));
      expect(driver.waitFor(find.text('2')), completes);
    });

    test('should clear the filters and reset the counter', () async {
      driver.scrollIntoView(find.text('Limpar'));
      expect(driver.waitFor(find.text('Limpar')), completes);
      await driver.tap(find.text('Limpar'));
      await Future.delayed(const Duration(seconds: 1));
      expect(driver.waitFor(find.text('0')), completes);
    });

    test('should pick another brand', () async {
      driver.scrollIntoView(find.byValueKey('3'));
      await driver.tap(find.byValueKey('3'));
      await Future.delayed(const Duration(seconds: 1));
    });

    test('should apply filters to search', () async {
      driver.scrollIntoView(find.text('Aplicar'));
      expect(driver.waitFor(find.text('Aplicar')), completes);
      await driver.tap(find.text('Aplicar'));
      await Future.delayed(const Duration(seconds: 3));
    });

    test('should pick a car to show its info', () async {
      await driver.tap(find.byValueKey('car-tile9'));
      await Future.delayed(const Duration(seconds: 3));
    });

    test('should back page', () async {
      await driver.tap(find.pageBack());
      await Future.delayed(const Duration(seconds: 3));
    });
  });
}
