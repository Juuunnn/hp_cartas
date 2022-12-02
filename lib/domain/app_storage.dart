// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hp_cartas/domain/character_card.dart';

class AppStorage {
  late Map<String, List<CharacterCard>> _obtainedCharacters;

  Map<String, List<CharacterCard>> get obtainedCharacters =>
      _obtainedCharacters;

  set obtainedCharacters(Map<String, List<CharacterCard>> obtainedCharacters) {
    _obtainedCharacters = obtainedCharacters;
  }

  bool daylyCharacterObtained;
  AppStorage({
    this.daylyCharacterObtained = true,
  }) {
    obtainedCharacters = {};
  }
}
