// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hp_cartas/domain/character_card.dart';

class AppStorage {
  final Map<String, List<CharacterCard>> _obtainedCharacters = {};
  bool daylyCharacterObtained;

  Map<String, List<CharacterCard>> get obtainedCharacters =>
      _obtainedCharacters;

  void newCharacter(CharacterCard character, String key) {
    _obtainedCharacters[key]!.add(character);
  }

  AppStorage({
    this.daylyCharacterObtained = true,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'daylyCharacterObtained': daylyCharacterObtained,
    };
  }

  factory AppStorage.fromMap(Map<String, dynamic> map) {
    return AppStorage(
      daylyCharacterObtained: map['daylyCharacterObtained'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppStorage.fromJson(String source) =>
      AppStorage.fromMap(json.decode(source) as Map<String, dynamic>);
}
