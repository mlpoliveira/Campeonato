// lib/screens/home_screen.dart
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final bool isAdmin;

  HomeScreen({required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela Principal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/match-registration');
              },
              child: Text('Cadastro de Partida'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/match-list');
              },
              child: Text('Lista de Partidas'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/pairings');
              },
              child: Text('Pareamentos'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/player-list');
              },
              child: Text('Lista de Jogadores'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/player-registration');
              },
              child: Text('Cadastro de Jogador'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/ranking');
              },
              child: Text('Ranking'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/player-profile');
              },
              child: Text('Perfil do Jogador'),
            ),
            if (isAdmin) ...[
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/championship-creation');
                },
                child: Text('Criação de Campeonato'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/championship-details');
                },
                child: Text('Detalhes do Campeonato'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
