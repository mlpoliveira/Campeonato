// lib/models/player.dart
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Player extends ParseObject implements ParseCloneable {
  Player() : super(_keyTableName);

  Player.clone() : this();

  static const String _keyTableName = 'Player';
  static const String keyName = 'name';
  static const String keyMissionPoints = 'missionPoints';
  static const String keyVictoryPoints = 'victoryPoints';
  static const String keySquad = 'squad';
  static const String keyPoints = 'points';

  @override
  Player clone(Map<String, dynamic> map) => Player.clone()..fromJson(map);

  String get name => get<String>(keyName) ?? '';
  set name(String name) => set<String>(keyName, name);

  int get missionPoints => get<int>(keyMissionPoints) ?? 0;
  set missionPoints(int missionPoints) => set<int>(keyMissionPoints, missionPoints);

  int get victoryPoints => get<int>(keyVictoryPoints) ?? 0;
  set victoryPoints(int victoryPoints) => set<int>(keyVictoryPoints, victoryPoints);

  String get squad => get<String>(keySquad) ?? '';
  set squad(String squad) => set<String>(keySquad, squad);

  int get points => get<int>(keyPoints) ?? 0;
  set points(int points) => set<int>(keyPoints, points);

  void fromJson(Map<String, dynamic> map) {
    name = map[keyName] ?? '';
    missionPoints = map[keyMissionPoints] ?? 0;
    victoryPoints = map[keyVictoryPoints] ?? 0;
    squad = map[keySquad] ?? '';
    points = map[keyPoints] ?? 0;
  }

  factory Player.fromJson(Map<String, dynamic> json) {
    final player = Player.clone();
    player.fromJson(json);
    return player;
  }
}
