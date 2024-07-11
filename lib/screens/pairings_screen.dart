// lib/screens/pairings_screen.dart
import 'package:flutter/material.dart';
import '../models/match.dart';

class PairingsScreen extends StatelessWidget {
  final List<Match> matches;

  PairingsScreen({required this.matches});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pareamentos'),
      ),
      body: ListView.builder(
        itemCount: matches.length,
        itemBuilder: (context, index) {
          final match = matches[index];
          return ListTile(
            title: Text('${match.teamA?.name ?? 'Desconhecido'} vs ${match.teamB?.name ?? 'Desconhecido'}'),
            subtitle: Text('Pontos: ${match.scoreA ?? 0} - ${match.scoreB ?? 0}'),
          );
        },
      ),
    );
  }
}
