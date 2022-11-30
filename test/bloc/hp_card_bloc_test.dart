import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hp_cartas/bloc/hp_card_bloc.dart';
import 'package:hp_cartas/domain/character.dart';
import 'package:hp_cartas/feature/characterCard/character_card_repo.dart';

const String testUrl = 'test/characters.json';

const duration = Duration(milliseconds: 100);

void main() {
  group('hp card bloc debe', () {
    blocTest<HpCardBloc, HpCardState>(
      'deve poder mostrar la tarjeta de un personaje que contiene',
      build: () => HpCardBloc.tester(apiUrl: testUrl),
      act: (bloc) {
        Future.delayed(duration, () {
          bloc.add(SelectedCharacterCard(
              characterName: bloc.obtainedCharacters.first.name));
        });
      },
      wait: duration,
      skip: 2,
      expect: () => [isA<ShowingCharacterCard>()],
    );
    blocTest<HpCardBloc, HpCardState>(
      'deve poder obtener un nuevo personaje',
      build: () =>
          HpCardBloc.tester(apiUrl: testUrl, daylyCharacterObtained: true),
      act: (bloc) {
        Future.delayed(duration, () {
          bloc.add(InputedCharacterCode('289311629'));
        });
      },
      wait: duration,
      skip: 1,
      expect: () => [isA<LoadingData>(), isA<ShowingNewCharacterObtained>()],
    );
    blocTest<HpCardBloc, HpCardState>(
      'deve tirar error cuando el codigo es malo',
      build: () =>
          HpCardBloc.tester(apiUrl: testUrl, daylyCharacterObtained: true),
      act: (bloc) {
        Future.delayed(duration, () {
          bloc.add(InputedCharacterCode('28j3t129'));
        });
      },
      wait: duration,
      skip: 1,
      expect: () => [isA<LoadingData>(), isA<BadCodeInput>()],
    );
    blocTest<HpCardBloc, HpCardState>(
      'deve tirar error cuando el codigo no corresponde a un personaje',
      build: () =>
          HpCardBloc.tester(apiUrl: testUrl, daylyCharacterObtained: true),
      act: (bloc) {
        Future.delayed(duration, () {
          bloc.add(InputedCharacterCode('289311628'));
        });
      },
      wait: duration,
      skip: 1,
      expect: () => [isA<LoadingData>(), isA<NoMatchForCharacterCode>()],
    );
    // blocTest<HpCardBloc, HpCardState>(
    //   'deve poder mostrar la tarjeta de un personaje que contiene',
    //   build: () =>
    //       HpCardBloc.tester(apiUrl: testUrl, daylyCharacterObtained: true),
    //   act: (bloc) {
    //     Future.delayed(duration, () {
    //       bloc.add(SelectedCharacterCard(characterName: 'Harry Potter'));
    //     });
    //   },
    //   wait: duration,
    //   skip: 1,
    //   expect: () => [
    //     ShowingCharacterCard(HPCharacter.constructor(
    //       nameProp: 'Harry Potter',
    //       speciesProp: 'human',
    //       houseProp: 'Gryffindor',
    //       genderProp: 'male',
    //       dateOfBirthProp: '31-07-1980',
    //       ancestryProp: 'half-blood',
    //       patronusProp: 'stag',
    //       wandProp: Barita(wood: "holly", core: "phoenix feather", length: 11),
    //       hogwartsStudentProp: true,
    //       hogwartsStaffProp: false,
    //       imageUrl: 'https://hp-api.herokuapp.com/images/harry.jpg',
    //     ))
    //   ],
    // );
    blocTest<HpCardBloc, HpCardState>(
      'deve poder mostrar la lista de personajes despues de mostrar tarjeta ',
      build: () => HpCardBloc.tester(apiUrl: testUrl),
      act: (bloc) {
        Future.delayed(duration, () {
          bloc.add(SelectedCharacterCard(
              characterName: bloc.obtainedCharacters.first.name));
          bloc.add(NavegatedToCharacterList());
        });
      },
      wait: duration,
      skip: 2,
      expect: () => [isA<ShowingCharacterCard>(), isA<ShowingCharacterList>()],
    );
    blocTest<HpCardBloc, HpCardState>(
      'deve desbloquear un nuevo personaje al iniciar',
      build: () => HpCardBloc.tester(apiUrl: testUrl),
      verify: (bloc) => bloc.obtainedCharacters.length = 1,
      wait: duration,
    );
    blocTest<HpCardBloc, HpCardState>(
      'deve poder tirar mala comunicacion',
      build: () =>
          HpCardBloc.tester(apiUrl: 'adsfa', daylyCharacterObtained: true),
      wait: duration,
      expect: () => [isA<DataComunicatioError>()],
    );
  });
}
