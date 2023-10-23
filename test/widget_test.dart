import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:imc_calculator/src/init_widget.dart';

void main() {
  testWidgets('Teste de cálculo de IMC', (WidgetTester tester) async {
    await tester.pumpWidget(const InitApp());

    final nomeTextField = find.byKey(const Key('nomeTextField'));
    final pesoTextField = find.byKey(const Key('pesoTextField'));
    final alturaTextField = find.byKey(const Key('alturaTextField'));
    final calcularButton = find.byKey(const Key('calcularButton'));

    await tester.enterText(nomeTextField, 'Milene');
    await tester.enterText(pesoTextField, '55');
    await tester.enterText(alturaTextField, '1.67');

    await tester.tap(calcularButton);
    await tester.pump();

    final imcText = find.text('IMC: 19.7');
    expect(imcText, findsOneWidget);

    final resultadoText = find.text('Resultado: Saudável');
    expect(resultadoText, findsOneWidget);
  });
}
