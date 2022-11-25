import 'package:fpdart/fpdart.dart';
import 'package:hp_cartas/domain/character.dart';
import 'package:hp_cartas/domain/problem.dart';

abstract class CharacterCardRepo {
  Either<Problem, HPCharacter> getCharacterData();
}

class CharacterCardRepoTest extends CharacterCardRepo {
  @override
  Either<Problem, HPCharacter> getCharacterData() {
    // TODO: implement getCharacterData
    throw UnimplementedError();
  }
}
