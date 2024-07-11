// lib/screens/championship_details_screen.dart
import 'package:flutter/material.dart';
import '../models/championship.dart';

class ChampionshipDetailsScreen extends StatelessWidget {
  final Championship championship;

  ChampionshipDetailsScreen({required this.championship});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Campeonato'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome: ${championship.name}', style: TextStyle(fontSize: 20)),
            Text('Número de Rodadas: ${championship.rounds}', style: TextStyle(fontSize: 18)),
            // Adicione mais informações conforme necessário
          ],
        ),
      ),
    );
  }
}
