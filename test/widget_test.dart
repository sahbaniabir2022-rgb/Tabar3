import 'package:flutter_test/flutter_test.dart';
import 'package:tabar3/main.dart';

void main() {
  testWidgets('Tabarra3 affiche la page accueil', (tester) async {
    await tester.pumpWidget(const Tabarra3App());

    expect(find.text('Tabarra3 - Don de sang'), findsOneWidget);
    expect(find.text('Centres disponibles'), findsOneWidget);
  });
}