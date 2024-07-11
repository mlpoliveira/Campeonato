//import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../models/player.dart';
import '../models/match.dart';

class AppParseConfig {
  static const String applicationId = 'V3vBbmkfdofDHeyOnPO0qYed4ELKfKnHlOkAfbSL';
  static const String clientKey = 'IaVoTZOqaSwPOkwa36EFOCmqXmv8Dbatp6CD2x7S';
  static const String serverUrl = 'https://parseapi.back4app.com';
}

class ParseService {
  static Future<void> initializeParse() async {
    await Parse().initialize(
      AppParseConfig.applicationId,
      AppParseConfig.serverUrl,
      clientKey: AppParseConfig.clientKey,
      autoSendSessionId: true,
      debug: true,
    );
  }

  Future<List<Player>> getPlayers() async {
    final query = QueryBuilder<Player>(Player());
    final response = await query.query();

    if (response.success && response.results != null) {
      return response.results!.cast<Player>();
    } else {
      print('Erro ao obter jogadores: ${response.error?.message}');
      return [];
    }
  }

  Future<void> createMatch(Match match) async {
    final response = await match.save();
    if (response.success) {
      print('Partida criada com sucesso');
    } else {
      print('Erro ao criar partida: ${response.error?.message}');
    }
  }

  Future<List<Match>> getMatches() async {
    final query = QueryBuilder<Match>(Match());
    final response = await query.query();

    if (response.success && response.results != null) {
      return response.results!.cast<Match>();
    } else {
      print('Erro ao obter partidas: ${response.error?.message}');
      return [];
    }
  }
}
