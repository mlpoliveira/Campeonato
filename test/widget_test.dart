import 'package:championship_manager/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Teste inicial da tela principal', (WidgetTester tester) async {
    // Construa o aplicativo e acione um frame.
    await tester.pumpWidget(MyApp());

    // Verifique se a tela inicial do aplicativo é exibida corretamente.
    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.text('Campeonato Manager'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);

    // Simula o toque no ícone de adicionar e aciona um novo frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verifique a presença de um widget de tela de "Cadastro de Campeonato" após o toque no ícone de adicionar.
    expect(find.text('Cadastrar Campeonato'), findsOneWidget);
  });
}
