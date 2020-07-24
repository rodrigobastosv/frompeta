import 'package:flutter_test/flutter_test.dart';
import 'package:flutterdryve/main.dart';

void main() {
  testWidgets('MyApp', (tester) async {
    await tester.pumpWidget(MyApp());
    await tester.pump();
    await tester.pumpAndSettle();
  });
}
