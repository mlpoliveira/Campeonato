import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'player.dart';
import 'championship.dart';

class Ranking extends ParseObject implements ParseCloneable {
  Ranking() : super('Ranking');

  Ranking.clone() : this();

  @override
  Ranking clone(Map<String, dynamic> map) => Ranking.clone()..fromJson(map);

  Future<Player?> getPlayer() async {
    final playerRelation = get<ParseRelation>('player');
    if (playerRelation != null) {
      final query = QueryBuilder<Player>(Player())
        ..whereRelatedTo('player', 'Ranking', objectId!);
      final response = await query.query();
      return response.success ? response.results?.first as Player? : null;
    }
    return null;
  }

  set player(Player? player) {
    if (player != null) {
      setAdd('player', player);
    }
  }

  int? get points => get<int>('points');
  set points(int? points) => set<int>('points', points ?? 0);

  Future<Championship?> getChampionship() async {
    final championshipRelation = get<ParseRelation>('championship');
    if (championshipRelation != null) {
      final query = QueryBuilder<Championship>(Championship())
        ..whereRelatedTo('championship', 'Ranking', objectId!);
      final response = await query.query();
      return response.success ? response.results?.first as Championship? : null;
    }
    return null;
  }

  set championship(Championship? championship) {
    if (championship != null) {
      setAdd('championship', championship);
    }
  }

  Future<void> saveRanking() async {
    final response = await save();
    if (!response.success) {
      throw Exception('Failed to save ranking: ${response.error?.message}');
    }
  }
}
