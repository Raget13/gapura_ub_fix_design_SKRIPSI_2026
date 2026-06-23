import 'package:flutter_test/flutter_test.dart';

import 'package:gapura_ub_fixing_design/main.dart';

void main() {
  testWidgets('App loads SplashScreen', (WidgetTester tester) async {
    await tester.pumpWidget(const GapuraUBApp());

    expect(find.text('Satu Aplikasi'), findsOneWidget);
    expect(find.text('Lewati'), findsOneWidget);
  });
}
