// lib/screens/match_registration_screen.dart
import 'package:championship_manager/models/player.dart';
import 'package:flutter/material.dart';
import '../services/parse_service.dart';
import '../models/match.dart';

class MatchRegistrationScreen extends StatefulWidget {
  @override
  _MatchRegistrationScreenState createState() => _MatchRegistrationScreenState();
}

class _MatchRegistrationScreenState extends State<MatchRegistrationScreen> {
  final _teamAController = TextEditingController();
  final _teamBController = TextEditingController();
  final _scoreAController = TextEditingController();
  final _scoreBController = TextEditingController();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Partida'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _teamAController,
              decoration: InputDecoration(labelText: 'Equipe A'),
            ),
            TextField(
              controller: _teamBController,
              decoration: InputDecoration(labelText: 'Equipe B'),
            ),
            TextField(
              controller: _scoreAController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Pontuação A'),
            ),
            TextField(
              controller: _scoreBController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Pontuação B'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (_teamAController.text.isNotEmpty && _teamBController.text.isNotEmpty) {
                  final match = Match()
                    ..teamA = _teamAController.text as Player?
                    ..teamB = _teamBController.text as Player?
                    ..scoreA = int.tryParse(_scoreAController.text) ?? 0
                    ..scoreB = int.tryParse(_scoreBController.text) ?? 0
                    ..time = _selectedDate;

                  await ParseService().createMatch(match);

                  Navigator.pop(context);
                }
              },
              child: Text('Registrar Partida'),
            ),
          ],
        ),
      ),
    );
  }
}
