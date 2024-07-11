import 'package:flutter/material.dart';
import '../models/match.dart';
import '../services/parse_service.dart';

class MatchListScreen extends StatefulWidget {
  @override
  _MatchListScreenState createState() => _MatchListScreenState();
}

class _MatchListScreenState extends State<MatchListScreen> {
  late Future<List<Match>> _matches;

  @override
  void initState() {
    super.initState();
    _matches = ParseService().getMatches();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Partidas'),
      ),
      body: FutureBuilder<List<Match>>(
        future: _matches,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhuma partida encontrada'));
          }

          final matches = snapshot.data!;

          return ListView.builder(
            itemCount: matches.length,
            itemBuilder: (context, index) {
              final match = matches[index];
              return ListTile(
                title: Text('${match.teamA} vs ${match.teamB}'),
                subtitle: Text('${match.scoreA} - ${match.scoreB}'),
              );
            },
          );
        },
      ),
    );
  }
}
