// lib/screens/ranking_screen.dart
import 'package:flutter/material.dart';
import '../models/player.dart';

class RankingScreen extends StatelessWidget {
  final List<Player> players;

  RankingScreen({required this.players});

  @override
  Widget build(BuildContext context) {
    // Ordene os jogadores por pontos de vitória e, em caso de empate, por pontos de missão
    players.sort((a, b) {
      if (a.victoryPoints != b.victoryPoints) {
        return b.victoryPoints.compareTo(a.victoryPoints);
      } else {
        return b.missionPoints.compareTo(a.missionPoints);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Ranking'),
      ),
      body: ListView.builder(
        itemCount: players.length,
        itemBuilder: (context, index) {
          final player = players[index];
          return ListTile(
            title: Text(player.name),
            subtitle: Text(
              'Pontos de Missão: ${player.missionPoints}, Pontos de Vitória: ${player.victoryPoints}',
            ),
            leading: CircleAvatar(
              child: Text(player.name[0]), // Exibe a inicial do nome do jogador
            ),
          );
        },
      ),
    );
  }
}
