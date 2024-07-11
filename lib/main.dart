import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/match_registration_screen.dart';
import 'screens/match_list_screen.dart';
import 'screens/pairings_screen.dart';
import 'screens/player_list_screen.dart';
import 'screens/player_registration_screen.dart';
import 'screens/ranking_screen.dart';
import 'screens/player_profile_screen.dart';
import 'screens/championship_creation_screen.dart';
import 'screens/championship_details_screen.dart';
import 'models/match.dart';
import 'models/player.dart';
import 'models/championship.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Parse().initialize(
    'V3vBbmkfdofDHeyOnPO0qYed4ELKfKnHlOkAfbSL', // Substitua pelo seu Application ID
    'https://parseapi.back4app.com', // Substitua pela URL do seu Parse Server (Back4App)
    clientKey: 'IaVoTZOqaSwPOkwa36EFOCmqXmv8Dbatp6CD2x7S', // Substitua pelo seu Client Key
    autoSendSessionId: true,
    debug: true,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<List<Match>> fetchMatches() async {
    final query = QueryBuilder<ParseObject>(ParseObject('Match'))
      ..orderByDescending('createdAt');
    final response = await query.query();
    if (response.success && response.results != null) {
      return response.results!.map((e) => Match.fromJson(e.toJson())).toList();
    }
    return [];
  }

  Future<List<Player>> fetchPlayers() async {
    final query = QueryBuilder<ParseObject>(ParseObject('Player'))
      ..orderByDescending('createdAt');
    final response = await query.query();
    if (response.success && response.results != null) {
      return response.results!.map((e) => Player.fromJson(e.toJson())).toList();
    }
    return [];
  }

  Future<Championship?> fetchChampionship() async {
    final query = QueryBuilder<ParseObject>(ParseObject('Championship'))
      ..orderByDescending('createdAt')
      ..setLimit(1); // Buscar apenas o campeonato mais recente
    final response = await query.query();
    if (response.success && response.results != null && response.results!.isNotEmpty) {
      return Championship.fromJson(response.results!.first.toJson());
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Championship Manager',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomeScreen(isAdmin: true), // Ajuste isAdmin conforme necessário
        '/match-registration': (context) => MatchRegistrationScreen(),
        '/match-list': (context) => MatchListScreen(),
        '/pairings': (context) => FutureBuilder<List<Match>>(
          future: fetchMatches(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erro ao carregar partidas.'));
            } else if (snapshot.hasData) {
              return PairingsScreen(matches: snapshot.data!);
            } else {
              return Center(child: Text('Nenhuma partida encontrada.'));
            }
          },
        ),
        '/player-list': (context) => PlayerListScreen(),
        '/player-registration': (context) => PlayerRegistrationScreen(),
        '/ranking': (context) => FutureBuilder<List<Player>>(
          future: fetchPlayers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erro ao carregar jogadores.'));
            } else if (snapshot.hasData) {
              return RankingScreen(players: snapshot.data!);
            } else {
              return Center(child: Text('Nenhum jogador encontrado.'));
            }
          },
        ),
        '/player-profile': (context) => PlayerProfileScreen(player: Player()), // Ajuste conforme necessário
        '/championship-creation': (context) => ChampionshipCreationScreen(),
        '/championship-details': (context) => FutureBuilder<Championship?>(
          future: fetchChampionship(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erro ao carregar o campeonato.'));
            } else if (snapshot.hasData && snapshot.data != null) {
              return ChampionshipDetailsScreen(championship: snapshot.data!);
            } else {
              return Center(child: Text('Nenhum campeonato encontrado.'));
            }
          },
        ),
      },
    );
  }
}
