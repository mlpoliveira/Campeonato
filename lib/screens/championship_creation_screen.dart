import 'package:flutter/material.dart';
//import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../models/championship.dart';

class ChampionshipCreationScreen extends StatefulWidget {
  @override
  _ChampionshipCreationScreenState createState() => _ChampionshipCreationScreenState();
}

class _ChampionshipCreationScreenState extends State<ChampionshipCreationScreen> {
  final TextEditingController _nameController = TextEditingController();
  int _rounds = 3;

  Future<void> _createChampionship() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Por favor, insira o nome do campeonato')));
      return;
    }

    final championship = Championship()
      ..name = name
      ..rounds = _rounds;

    final response = await championship.save();

    if (response.success) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Campeonato criado com sucesso')));
      _nameController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao criar campeonato: ${response.error?.message ?? 'Unknown error'}'),
      ));
    }

  }

  Future<void> _logout() async {
    final user = await ParseUser.currentUser() as ParseUser?;
    if (user != null) {
      await user.logout();
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criação de Campeonato'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nome do Campeonato'),
            ),
            DropdownButton<int>(
              value: _rounds,
              items: [3, 4, 5, 6, 7].map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text('$value rounds'),
                );
              }).toList(),
              onChanged: (int? newValue) {
                setState(() {
                  _rounds = newValue!;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _createChampionship,
              child: Text('Criar'),
            ),
          ],
        ),
      ),
    );
  }
}
