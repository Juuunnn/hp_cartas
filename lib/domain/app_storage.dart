// ignore_for_file: public_member_api_docs, sort_constructors_first
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
}
