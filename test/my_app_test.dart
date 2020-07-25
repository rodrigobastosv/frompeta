import 'package:flutter_test/flutter_test.dart';
import 'package:flutterdryve/main.dart';
import 'package:flutterdryve/service/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mocks.dart';

SharedPreferences sharedPreferences;

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    initLocator(MockSharedPreferences());
  });

  testWidgets('MyApp', (tester) async {
    await tester.pumpWidget(MyApp());
    await tester.pump();
    await tester.pumpAndSettle();
  });
}
