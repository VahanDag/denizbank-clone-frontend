import 'package:denizbank_clone/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Random Test smoke', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verify that our counter starts at 0.
    expect(find.text('Hello World'), findsOneWidget);
    final field = find.bySemanticsLabel("textfield");
    await tester.tap(field);
    // TextField'ı bul ve içine metin gir
    await tester.enterText(find.byType(TextField), "vsdsa@sdf.com");
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // Girilen metni kontrol et
    expect(find.text("vsdsa@sdf.com"), findsOneWidget);
  });
}
