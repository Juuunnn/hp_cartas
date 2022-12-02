// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hp_cartas/feature/characterCard/spell_repo.dart';
import 'package:meta/meta.dart';

import 'package:hp_cartas/domain/character.dart';
import 'package:hp_cartas/domain/code_input.dart';
import 'package:hp_cartas/domain/problem.dart';
import 'package:hp_cartas/domain/spell.dart';
import 'package:hp_cartas/feature/characterCard/character_repo.dart';
import 'package:hp_cartas/feature/characterDataProvider/api_data_provider.dart';

part 'hp_card_event.dart';
part 'hp_card_state.dart';

class HpCardBloc extends Bloc<HpCardEvent, HpCardState> {
  final CharacterRepo cardRepo;
  final SpellRepo spellRepo;
  final ApiDataProvider dataProvider;
  Map<String, List<CharacterCard>> obtainedCharacters = {};
  bool daylyCharacterObtained;

  HpCardBloc._({
    required this.cardRepo,
    required this.spellRepo,
    required this.dataProvider,
    this.daylyCharacterObtained = false,
  }) : super(HpCardInitial()) {
    on<InputedCharacterCode>((event, emit) async {
      emit(LoadingData());
      final characterObtained = await cardRepo.getCharacterWithCode(
          characterCode: event.codeInput, apiDataProvider: dataProvider);
      characterObtained.match(
        (l) {
          emit(ErrorInesperado(l));
        },
        (r) {
          if (r == null) {
            emit(NoMatchForCharacterCode());
          } else {
            add(ObtainedNewCharacter(r));
          }
        },
      );
    });
    on<ObtainedCharacterOfTheDay>((event, emit) async {
      final fullCharacterList =
          await cardRepo.getCharacterNameList(apiDataProvider: dataProvider);
      await fullCharacterList.match((l) {
        emit(ErrorInesperado(l));
      }, (r) async {
        final characterName = r.elementAt(randomInt(0, r.length).run());
        final newCharacter = await cardRepo.getCharacterWithName(
            characterName: characterName, apiDataProvider: dataProvider);
        await newCharacter.match(
          (l) {
            emit(ErrorInesperado(l));
          },
          (r) async {
            add(ObtainedNewCharacter(r));
          },
        );
      });
    });
    on<StartedLoadingData>((event, emit) async {
      //comprueba que haiga coneccion con el servidor
      final characterDataRecived = await dataProvider.getCharacterListFromAPI();
      characterDataRecived.match((l) {
        emit(DataComunicatioError(l));
      }, (r1) {
        add(NavegatedToCharacterList());
      });
    });
    on<SelectedCharacterCard>((event, emit) {
      List<CharacterCard>? result = obtainedCharacters[event.characterName];
      if (result == null) {
        emit(ErrorInesperado(
            UnknownProblem('error buscando el personaje localmente')));
      } else {
        emit(ShowingCharacterCard(result));
      }
      // final result = cardRepo.getCharacterData(
      //     characterName: event.characterName, elJson: rawData);
    });
    on<NavegatedToCharacterList>((event, emit) async {
      final result =
          await cardRepo.getCharacterNameList(apiDataProvider: dataProvider);
      result.match((l) {
        emit(ErrorInesperado(l));
      }, ((r) {
        if (!daylyCharacterObtained) {
          daylyCharacterObtained = true;
          add(ObtainedCharacterOfTheDay());
        }
        emit(ShowingCharacterList(
            r,
            obtainedCharacters
                .map((key, value) => MapEntry(key, value.length))));
      }));
    });
    on<ObtainedNewCharacter>((event, Emitter<HpCardState> emit) async {
      if (!obtainedCharacters.containsKey(event.character.name)) {
        obtainedCharacters[event.character.name] = [];
      }
      final spellSearchResult =
          await spellRepo.getSpellList(apiDataProvider: dataProvider);
      spellSearchResult.match((l) {
        emit(ErrorInesperado(l));
      }, (r) {
        final spellList = [
          r.removeAt(Random().nextInt(r.length)),
          r.removeAt(Random().nextInt(r.length)),
          r.removeAt(Random().nextInt(r.length)),
        ];
        obtainedCharacters[event.character.name]!.add(CharacterCard.constructor(
            character: event.character, spells: spellList));
        emit(ShowingNewCharacterObtained(event.character));
      });
    });
  }

  factory HpCardBloc.constructor({
    required String apiUrl,
    required CharacterRepo cardRepo,
    required SpellRepo spellRepo,
    required ApiDataProvider dataProvider,
  }) {
    HpCardBloc bloc = HpCardBloc._(
      cardRepo: cardRepo,
      dataProvider: dataProvider,
      spellRepo: spellRepo,
    );
    bloc.add(StartedLoadingData(apiUrl: apiUrl));
    return bloc;
  }

  factory HpCardBloc.tester({
    required String apiUrl,
    bool daylyCharacterObtained = false,
  }) {
    HpCardBloc bloc = HpCardBloc._(
      cardRepo: CharacterRepoTest(),
      spellRepo: SpellRepoTest(),
      dataProvider: ApiDataProviderTest(apiUrl),
      daylyCharacterObtained: daylyCharacterObtained,
    );
    bloc.add(StartedLoadingData(apiUrl: apiUrl));
    return bloc;
  }
}

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
}
