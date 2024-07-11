// lib/screens/player_profile_screen.dart
import 'package:flutter/material.dart';
import '../models/player.dart';

class PlayerProfileScreen extends StatelessWidget {
  final Player player;

  PlayerProfileScreen({required this.player});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil do Jogador'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome: ${player.name}', style: TextStyle(fontSize: 20)),
            Text('Equipe: ${player.squad}', style: TextStyle(fontSize: 18)),
            Text('Pontuação: ${player.points}', style: TextStyle(fontSize: 18)),
            // Adicione mais informações conforme necessário
          ],
        ),
      ),
    );
  }
}
