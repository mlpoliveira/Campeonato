// lib/models/championship.dart
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Championship extends ParseObject implements ParseCloneable {
  Championship() : super(_keyTableName);

  Championship.clone() : this();

  static const String _keyTableName = 'Championship';
  static const String keyName = 'name';
  static const String keyRounds = 'rounds';

  @override
  Championship clone(Map<String, dynamic> map) => Championship.clone()..fromJson(map);

  String get name => get<String>(keyName) ?? '';
  set name(String name) => set<String>(keyName, name);

  int get rounds => get<int>(keyRounds) ?? 0;
  set rounds(int rounds) => set<int>(keyRounds, rounds);

  void fromJson(Map<String, dynamic> map) {
    name = map[keyName] ?? '';
    rounds = map[keyRounds] ?? 0;
  }

  factory Championship.fromJson(Map<String, dynamic> json) {
    final championship = Championship.clone();
    championship.fromJson(json);
    return championship;
  }
}
