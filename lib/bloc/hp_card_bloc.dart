import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hp_cartas/domain/character.dart';
import 'package:hp_cartas/feature/characterCard/character_card_repo.dart';
import 'package:meta/meta.dart';

part 'hp_card_event.dart';
part 'hp_card_state.dart';

class HpCardBloc extends Bloc<HpCardEvent, HpCardState> {
  final CharacterCardRepo cardRepo = CharacterCardRepoTest();
  HpCardBloc() : super(HpCardInitial()) {
    on<SelectedCharacterCard>((event, emit) {
      final result =
          cardRepo.getCharacterData(characterName: event.characterName);
      result.match((l) {
        emit(ErrorInesperado(l.toString()));
      }, ((r) {
        emit(ShowingCharacterCard(r));
      }));
    });
    on<NavegatedToCharacterList>((event, emit) {
      emit(ShowingCharacterList());
    });
  }
}
