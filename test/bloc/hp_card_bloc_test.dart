import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hp_cartas/bloc/hp_card_bloc.dart';
import 'package:hp_cartas/domain/character.dart';
import 'package:hp_cartas/domain/code_input.dart';
import 'package:hp_cartas/feature/characterCard/character_repo.dart';

const String testUrl = 'test';

const duration = Duration(milliseconds: 300);
const testReview = Duration(milliseconds: 2000);
// si estos test fallan lo mas probable es que este relacionado con el tiempo
// que se tarden en ejecutar y el tiempo entre llamadas al bloc

//mejor ejemplo de test de multiples acciones es el que tiene async await.
void main() {
  group('hp card bloc debe', () {
    blocTest<HpCardBloc, HpCardState>(
      'deve poder mostrar la tarjeta de un personaje que contiene',
      build: () => HpCardBloc.tester(apiUrl: testUrl),
      act: (bloc) {
        Future.delayed(duration, () {
          bloc.add(SelectedCharacterCard(
              characterName: bloc.obtainedCharacters.entries.first.value.first
                  .character.name));
        });
      },
      wait: testReview,
      skip: 3,
      expect: () => [isA<ShowingCharacterCard>()],
    );
    blocTest<HpCardBloc, HpCardState>(
      'deve poder obtener un nuevo personaje',
      build: () =>
          HpCardBloc.tester(apiUrl: testUrl, daylyCharacterObtained: true),
      act: (bloc) {
        Future.delayed(duration, () {
          bloc.add(InputedCharacterCode(CodeInput.constructor('289311629')));
        });
      },
      wait: testReview,
      skip: 2,
      expect: () => [isA<LoadingData>(), isA<ShowingNewCharacterObtained>()],
    );
    blocTest<HpCardBloc, HpCardState>(
      'deve poder obtener y guardar un nuevo personaje',
      build: () => HpCardBloc.tester(apiUrl: testUrl),
      act: (bloc) {
        Future.delayed(duration, () {
          bloc.add(InputedCharacterCode(CodeInput.constructor('289311629')));
        });
      },
      wait: testReview,
      verify: (bloc) => bloc.obtainedCharacters.values.toList().length == 2,
      skip: 3,
      expect: () => [isA<LoadingData>(), isA<ShowingNewCharacterObtained>()],
    );
    blocTest<HpCardBloc, HpCardState>(
      'deve poder guardar varias copias de un personaje',
      build: () =>
          HpCardBloc.tester(apiUrl: testUrl, daylyCharacterObtained: true),
      act: (bloc) async {
        const time = 300;

        await Future.delayed(const Duration(milliseconds: time), () {
          bloc.add(InputedCharacterCode(CodeInput.constructor('289311629')));
        });
        await Future.delayed(const Duration(milliseconds: time * 3), () {
          bloc.add(NavegatedToCharacterList());
        });
        await Future.delayed(const Duration(milliseconds: time * 3), () {
          bloc.add(InputedCharacterCode(CodeInput.constructor('289311629')));
        });
      },
      wait: const Duration(milliseconds: 4000),
      verify: (bloc) => bloc.obtainedCharacters['Albert Runcorn']!.length == 4,
      skip: 2,
      expect: () => [
        isA<LoadingData>(),
        isA<ShowingNewCharacterObtained>(),
        isA<ShowingCharacterList>(),
        isA<LoadingData>(),
        isA<ShowingNewCharacterObtained>(),
      ],
    );
    // blocTest<HpCardBloc, HpCardState>(
    //   'deve tirar error cuando el codigo es malo',
    //   build: () =>
    //       HpCardBloc.tester(apiUrl: testUrl, daylyCharacterObtained: true),
    //   act: (bloc) {
    //     Future.delayed(duration, () {
    //       bloc.add(InputedCharacterCode('28j3t129'));
    //     });
    //   },
    //   wait: testReview,
    //   skip: 1,
    //   expect: () => [isA<LoadingData>(), isA<BadCodeInput>()],
    // );
    // blocTest<HpCardBloc, HpCardState>(
    //   'deve no encontrar a un personaje con 289311628',
    //   build: () =>
    //       HpCardBloc.tester(apiUrl: testUrl, daylyCharacterObtained: true),
    //   act: (bloc) {
    //     Future.delayed(duration, () {
    //       bloc.add(InputedCharacterCode('289311628'));
    //     });
    //   },
    //   wait: testReview,
    //   skip: 1,
    //   expect: () => [isA<LoadingData>(), isA<NoMatchForCharacterCode>()],
    // );
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
              characterName: bloc.obtainedCharacters.entries.first.key));
          bloc.add(NavegatedToCharacterList());
        });
      },
      wait: testReview,
      skip: 3,
      expect: () => [isA<ShowingCharacterCard>(), isA<ShowingCharacterList>()],
    );
    blocTest<HpCardBloc, HpCardState>(
      'deve desbloquear un nuevo personaje al iniciar',
      build: () => HpCardBloc.tester(apiUrl: testUrl),
      verify: (bloc) => bloc.obtainedCharacters.values.toList().length == 1,
      wait: testReview,
    );
    blocTest<HpCardBloc, HpCardState>(
      'deve poder tirar mala comunicacion',
      build: () =>
          HpCardBloc.tester(apiUrl: 'adsfa', daylyCharacterObtained: true),
      wait: testReview,
      skip: 1,
      expect: () => [isA<DataComunicatioError>()],
    );
  });
}
