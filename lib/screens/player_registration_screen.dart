import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../models/player.dart';

class PlayerRegistrationScreen extends StatefulWidget {
  @override
  _PlayerRegistrationScreenState createState() => _PlayerRegistrationScreenState();
}

class _PlayerRegistrationScreenState extends State<PlayerRegistrationScreen> {
  final _nameController = TextEditingController();
  final _missionPointsController = TextEditingController();
  final _victoryPointsController = TextEditingController();
  final _squadController = TextEditingController();

  Future<void> _registerPlayer() async {
    final player = Player()
      ..name = _nameController.text
      ..missionPoints = int.tryParse(_missionPointsController.text) ?? 0
      ..victoryPoints = int.tryParse(_victoryPointsController.text) ?? 0
      ..squad = _squadController.text;

    final response = await player.save();

    if (response.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Jogador cadastrado com sucesso!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao cadastrar jogador: ${response.error!.message}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Jogador'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _missionPointsController,
              decoration: InputDecoration(labelText: 'Pontos de Missão'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _victoryPointsController,
              decoration: InputDecoration(labelText: 'Pontos de Vitória'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _squadController,
              decoration: InputDecoration(labelText: 'Esquadrão'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _registerPlayer,
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
