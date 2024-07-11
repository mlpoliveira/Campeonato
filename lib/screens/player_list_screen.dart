import 'package:flutter/material.dart';
import '../models/player.dart';
import '../services/parse_service.dart';

class PlayerListScreen extends StatefulWidget {
  @override
  _PlayerListScreenState createState() => _PlayerListScreenState();
}

class _PlayerListScreenState extends State<PlayerListScreen> {
  late Future<List<Player>> _players;

  @override
  void initState() {
    super.initState();
    _players = ParseService().getPlayers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Jogadores'),
      ),
      body: FutureBuilder<List<Player>>(
        future: _players,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum jogador encontrado'));
          }

          final players = snapshot.data!;

          return ListView.builder(
            itemCount: players.length,
            itemBuilder: (context, index) {
              final player = players[index];
              return ListTile(
                title: Text(player.name),
                subtitle: Text(player.squad),
              );
            },
          );
        },
      ),
    );
  }
}
