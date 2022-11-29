import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hp_cartas/domain/character.dart';
import 'package:hp_cartas/domain/problem.dart';
import 'package:hp_cartas/feature/characterCard/character_card_repo.dart';
import 'package:meta/meta.dart';

part 'hp_card_event.dart';
part 'hp_card_state.dart';

class HpCardBloc extends Bloc<HpCardEvent, HpCardState> {
  final CharacterCardRepo cardRepo = CharacterCardRepoTest();
  HpCardBloc._() : super(LoadingData()) {
    on<SelectedCharacterCard>((event, emit) {
      final result =
          cardRepo.getCharacterData(characterName: event.characterName);
      result.match((l) {
        emit(ErrorInesperado(l));
      }, ((r) {
        emit(ShowingCharacterCard(r));
      }));
    });
    on<NavegatedToCharacterList>((event, emit) {
      final result = cardRepo.getCharacterNameList();
      result.match((l) {
        emit(ErrorInesperado(l));
      }, ((r) {
        emit(ShowingCharacterList(r));
      }));
    });
  }
  factory HpCardBloc.constructor() {
    return HpCardBloc._();
  }
}


	// TODO: 3. tener solo los personajes obtenidos y desbloquear/obtener los personajes con un sistema simple
	// 	mostrar que se obtuvo un nuevo personaje
	// >		obtener un personaje aleatoriamente cada nueva entrada diaria a la aplicacion

	// TODO: 4. tener una coleccion de todos los personajes obtenidos
	// 	mostrar solo los personajes obtenidos
	// 	mostrar un marcador cuantos personajes unicos hay en total
	// >		marcar diferente  los personajes que aun no se han obtenido a los obtenidos

	// TODO: 5. poder obtener personajes obtenidos por conocidos
	// 	mostrar una entrada para obtener personajes a proposito
	// >		cada personaje tendra un codigo que permitira compartir una copia con otra persona
