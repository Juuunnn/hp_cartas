import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hp_cartas/domain/character.dart';
import 'package:hp_cartas/domain/problem.dart';
import 'package:hp_cartas/feature/characterCard/character_card_repo.dart';
import 'package:hp_cartas/feature/characterDataProvider/character_data_provider.dart';
import 'package:meta/meta.dart';

part 'hp_card_event.dart';
part 'hp_card_state.dart';

class HpCardBloc extends Bloc<HpCardEvent, HpCardState> {
  final CharacterCardRepo cardRepo;
  final CharacterDataProvider dataProvider;
  HpCardBloc._({
    required this.cardRepo,
    required this.dataProvider,
  }) : super(HpCardInitial()) {
    on<StartedLoadingData>((event, emit) async {
      final dataRecived = await dataProvider.getFromAPI(event.apiUrl);
      dataRecived.match((l) {
        // emit();
      }, (r) {
        add(NavegatedToCharacterList());
      });
    });
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
  factory HpCardBloc.constructor({
    required String apiUrl,
    required CharacterCardRepo cardRepo,
    required CharacterDataProvider dataProvider,
  }) {
    HpCardBloc bloc =
        HpCardBloc._(cardRepo: cardRepo, dataProvider: dataProvider);
    bloc.add(StartedLoadingData(apiUrl: apiUrl));
    return bloc;
  }
  factory HpCardBloc.tester({required String apiUrl}) {
    HpCardBloc bloc = HpCardBloc._(
        cardRepo: CharacterCardRepoTest(),
        dataProvider: CharacterDataObtainerTest());
    bloc.add(StartedLoadingData(apiUrl: apiUrl));
    return bloc;
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
