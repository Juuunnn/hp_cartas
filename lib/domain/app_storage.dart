// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';

import 'package:hp_cartas/domain/character_card.dart';

class AppStorage {
  final Map<String, List<CharacterCard>> obtainedCharacters;
  bool daylyCharacterObtained;

  void newCharacter(CharacterCard character, String key) {
    obtainedCharacters[key]!.add(character);
  }

  AppStorage._(
      {required this.obtainedCharacters, required this.daylyCharacterObtained});

  factory AppStorage.constructor({
    bool daylyCharacterObtained = true,
  }) {
    return AppStorage._(
        obtainedCharacters: <String, List<CharacterCard>>{},
        daylyCharacterObtained: daylyCharacterObtained);
  }

  AppStorage copyWith({
    Map<String, List<CharacterCard>>? obtainedCharacters,
    bool? daylyCharacterObtained,
  }) {
    return AppStorage._(
      obtainedCharacters: obtainedCharacters ?? this.obtainedCharacters,
      daylyCharacterObtained:
          daylyCharacterObtained ?? this.daylyCharacterObtained,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'obtainedCharacters': obtainedCharacters,
      'daylyCharacterObtained': daylyCharacterObtained,
    };
  }

  factory AppStorage.fromMap(Map<String, dynamic> map) {
    var map2 = Map<String, dynamic>.from(map['obtainedCharacters']);
    final map3 = map2.entries;
    print(map3.runtimeType);
    final map4 = map3.map((e) => MapEntry(e.key,
        (e.value as List).map((e) => CharacterCard.fromJson(e)).toList()));
    print(map4.runtimeType);
    final map5 = map4.toList().asMap();
    print(map5.runtimeType);
    // print(map5.first);

    return AppStorage._(
      obtainedCharacters: Map.fromEntries(map4),
      daylyCharacterObtained: map['daylyCharacterObtained'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppStorage.fromJson(String source) =>
      AppStorage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AppStorage(obtainedCharacters: $obtainedCharacters, daylyCharacterObtained: $daylyCharacterObtained)';

  @override
  bool operator ==(covariant AppStorage other) {
    if (identical(this, other)) return true;

    return mapEquals(other.obtainedCharacters, obtainedCharacters) &&
        other.daylyCharacterObtained == daylyCharacterObtained;
  }

  @override
  int get hashCode =>
      obtainedCharacters.hashCode ^ daylyCharacterObtained.hashCode;
}
