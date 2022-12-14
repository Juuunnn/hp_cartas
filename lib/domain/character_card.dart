// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:hp_cartas/domain/character.dart';
import 'package:hp_cartas/domain/problem.dart';
import 'package:hp_cartas/domain/spell.dart';

class CharacterCard {
  final HPCharacter character;
  final List<Spell> spells;
  CharacterCard._({
    required this.character,
    required this.spells,
  });

  /// el largo de la lista de hechizos debe ser 3 exactamente
  factory CharacterCard.constructor(
      {required HPCharacter character, required List<Spell> spells}) {
    if (spells.length != 3) {
      throw IncorrectSpellLength();
    }
    return CharacterCard._(character: character, spells: spells);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'character': character.toMap(),
      'spells': spells.map((x) => x.toMap()).toList(),
    };
  }

  factory CharacterCard.fromMap(Map<String, dynamic> map) {
    return CharacterCard._(
      character: HPCharacter.fromMap(map['character'] as Map<String, dynamic>),
      spells: List<Spell>.from(
        (map['spells'] as List<dynamic>).map<Spell>(
          (x) => Spell.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory CharacterCard.fromJson(String source) =>
      CharacterCard.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant CharacterCard other) {
    if (identical(this, other)) return true;

    return other.character == character && listEquals(other.spells, spells);
  }

  @override
  int get hashCode => character.hashCode ^ spells.hashCode;

  CharacterCard copyWith({
    HPCharacter? character,
    List<Spell>? spells,
  }) {
    return CharacterCard._(
      character: character ?? this.character,
      spells: spells ?? this.spells,
    );
  }

  @override
  String toString() => 'CharacterCard(character: $character, spells: $spells)';
}
