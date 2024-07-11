// lib/models/match.dart
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'player.dart';

class Match extends ParseObject implements ParseCloneable {
  Match() : super(_keyTableName);

  Match.clone() : this();

  static const String _keyTableName = 'Match';
  static const String keyTeamA = 'teamA';
  static const String keyTeamB = 'teamB';
  static const String keyScoreA = 'scoreA';
  static const String keyScoreB = 'scoreB';
  static const String keyTime = 'time';

  @override
  Match clone(Map<String, dynamic> map) => Match.clone()..fromJson(map);

  Player? get teamA => get<Player>(keyTeamA);
  set teamA(Player? value) => set<Player>(keyTeamA, value!);

  Player? get teamB => get<Player>(keyTeamB);
  set teamB(Player? value) => set<Player>(keyTeamB, value!);

  int? get scoreA => get<int>(keyScoreA);
  set scoreA(int? value) => set<int>(keyScoreA, value!);

  int? get scoreB => get<int>(keyScoreB);
  set scoreB(int? value) => set<int>(keyScoreB, value!);

  DateTime? get time => get<DateTime>(keyTime);
  set time(DateTime? value) => set<DateTime>(keyTime, value!);

  void fromJson(Map<String, dynamic> map) {
    teamA = map[keyTeamA] != null ? Player.fromJson(map[keyTeamA]) : null;
    teamB = map[keyTeamB] != null ? Player.fromJson(map[keyTeamB]) : null;
    scoreA = map[keyScoreA];
    scoreB = map[keyScoreB];
    time = map[keyTime] != null ? DateTime.parse(map[keyTime]) : null;
  }

  factory Match.fromJson(Map<String, dynamic> json) {
    final match = Match.clone();
    match.fromJson(json);
    return match;
  }
}
