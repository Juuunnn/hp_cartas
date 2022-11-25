import 'package:hp_cartas/domain/character.dart';

abstract class CharacterCardRepo {
  HPCharacter getCharacterData();
}

class CharacterCardRepoTest extends CharacterCardRepo {
  @override
  HPCharacter getCharacterData() {
    // TODO: implement getCharacterData
    throw UnimplementedError();
  }
}
