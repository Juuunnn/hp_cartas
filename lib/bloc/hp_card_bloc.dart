import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hp_cartas/domain/character.dart';
import 'package:hp_cartas/domain/code_input.dart';
import 'package:hp_cartas/domain/problem.dart';
import 'package:hp_cartas/feature/characterCard/character_repo.dart';
import 'package:hp_cartas/feature/characterDataProvider/character_data_provider.dart';
import 'package:meta/meta.dart';

part 'hp_card_event.dart';
part 'hp_card_state.dart';

class HpCardBloc extends Bloc<HpCardEvent, HpCardState> {
  final CharacterRepo cardRepo;
  final CharacterDataProvider dataProvider;
  late final String rawData;
  Map<String, List<HPCharacter>> obtainedCharacters = {};
  bool daylyCharacterObtained;

  HpCardBloc._({
    required this.cardRepo,
    required this.dataProvider,
    this.daylyCharacterObtained = false,
  }) : super(HpCardInitial()) {
    on<InputedCharacterCode>((event, emit) {
      emit(LoadingData());
      Either<Problem, CodeInput> codigo() {
        try {
          return right(CodeInput.constructor(event.propCharacter));
        } on InvalidCode catch (e) {
          return left(e);
        } catch (e) {
          return left(UnknownProblem(e.toString()));
        }
      }

      codigo().match(
        (l) {
          if (l is InvalidCode) {
            emit(BadCodeInput(l));
          } else {
            emit(ErrorInesperado(l));
          }
        },
        (r) {
          final characterObtained =
              cardRepo.getCharacterWithCode(characterCode: r, elJson: rawData);
          characterObtained.match(
            (l) {
              emit(ErrorInesperado(l));
            },
            (r) {
              if (r == null) {
                emit(NoMatchForCharacterCode());
              } else {
                obtainedNewCharacter(r, emit);
              }
            },
          );
        },
      );
    });
    on<ObtainedNewCharacter>((event, emit) {
      final fullCharacterList = cardRepo.getCharacterNameList(elJson: rawData);
      fullCharacterList.match((l) {
        emit(ErrorInesperado(l));
      }, (r) {
        final characterName = r.elementAt(randomInt(0, r.length).run());
        final newCharacter = cardRepo.getCharacterWithName(
            characterName: characterName, elJson: rawData);
        newCharacter.match((l) {
          emit(ErrorInesperado(l));
        }, (r) {
          obtainedNewCharacter(r, emit);
        });
      });
    });
    on<StartedLoadingData>((event, emit) async {
      final dataRecived = await dataProvider.getFromAPI(event.apiUrl);
      dataRecived.match((l) {
        emit(DataComunicatioError(l));
      }, (r) {
        rawData = r;
        add(NavegatedToCharacterList());
      });
    });
    on<SelectedCharacterCard>((event, emit) {
      List<HPCharacter>? result = obtainedCharacters[event.characterName];
      if (result == null) {
        emit(ErrorInesperado(
            UnknownProblem('error buscando el personaje localmente')));
      } else {
        emit(ShowingCharacterCard(result));
      }
      // final result = cardRepo.getCharacterData(
      //     characterName: event.characterName, elJson: rawData);
    });
    on<NavegatedToCharacterList>((event, emit) {
      final result = cardRepo.getCharacterNameList(elJson: rawData);
      result.match((l) {
        emit(ErrorInesperado(l));
      }, ((r) {
        if (!daylyCharacterObtained) {
          daylyCharacterObtained = true;
          add(ObtainedNewCharacter());
        }
        emit(ShowingCharacterList(
            r,
            obtainedCharacters
                .map((key, value) => MapEntry(key, value.length))));
      }));
    });
  }

  void obtainedNewCharacter(HPCharacter r, Emitter<HpCardState> emit) {
    if (!obtainedCharacters.containsKey(r.name)) {
      obtainedCharacters[r.name] = [];
    }
    obtainedCharacters[r.name]!.add(r);
    emit(ShowingNewCharacterObtained(r));
  }

  factory HpCardBloc.constructor({
    required String apiUrl,
    required CharacterRepo cardRepo,
    required CharacterDataProvider dataProvider,
  }) {
    HpCardBloc bloc =
        HpCardBloc._(cardRepo: cardRepo, dataProvider: dataProvider);
    bloc.add(StartedLoadingData(apiUrl: apiUrl));
    return bloc;
  }

  factory HpCardBloc.tester(
      {required String apiUrl, bool daylyCharacterObtained = false}) {
    HpCardBloc bloc = HpCardBloc._(
        cardRepo: CharacterRepoTest(),
        dataProvider: CharacterDataObtainerTest(),
        daylyCharacterObtained: daylyCharacterObtained);
    bloc.add(StartedLoadingData(apiUrl: apiUrl));
    return bloc;
  }
}
