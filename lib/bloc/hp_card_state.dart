// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'hp_card_bloc.dart';

@immutable
abstract class HpCardState extends Equatable {}

class HpCardInitial extends HpCardState {
  @override
  List<Object?> get props => [];
}

class LoadingData extends HpCardState {
  @override
  List<Object?> get props => [];
}

class ShowingCharacterCard extends HpCardState {
  final HPCharacter character;

  ShowingCharacterCard(this.character);

  @override
  List<Object?> get props => [character];
}

class ShowingCharacterList extends HpCardState {
  final List<String> characterList;

  ShowingCharacterList(this.characterList);
  @override
  List<Object?> get props => [characterList];
}

abstract class EstadoProblemaEsperado extends HpCardState {}

class ErrorInesperado extends EstadoProblemaEsperado {
  final Problem problem;

  ErrorInesperado(this.problem);

  @override
  List<Object?> get props => [problem];
}
