import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hp_cartas/bloc/hp_card_bloc.dart';
import 'package:hp_cartas/domain/character.dart';

void main() {
  group('hp card bloc debe', () {
    blocTest<HpCardBloc, HpCardState>(
      'deve poder mostrar la tarjeta de un personaje',
      build: () => HpCardBloc(),
      act: (bloc) =>
          bloc.add(SelectedCharacterCard(characterName: 'Harry Potter')),
      expect: () => [
        ShowingCharacterCard(HPCharacter.constructor(
          nameProp: 'Harry Potter',
          speciesProp: 'human',
          houseProp: 'Gryffindor',
          genderProp: 'male',
          dateOfBirthProp: '31-07-1980',
          ancestryProp: 'half-blood',
          patronusProp: 'stag',
          wandProp: Barita(wood: "holly", core: "phoenix feather", length: 11),
          hogwartsStudentProp: true,
          hogwartsStaffProp: false,
          imageUrl: 'https://hp-api.herokuapp.com/images/harry.jpg',
        ))
      ],
    );
    blocTest<HpCardBloc, HpCardState>(
      'deve poder mostrar la lista de personajes ',
      build: () => HpCardBloc(),
      act: (bloc) => bloc.add(NavegatedToCharacterList()),
      expect: () => [isA<ShowingCharacterList>()],
    );
  });
}
