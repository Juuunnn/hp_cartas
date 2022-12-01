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

class ShowingNewCharacterObtained extends HpCardState {
  final HPCharacter character;

  ShowingNewCharacterObtained(this.character);

  @override
  List<Object?> get props => [character];
}

class ShowingCharacterCard extends HpCardState {
  final List<CharacterCard> character;

  ShowingCharacterCard(this.character);

  @override
  List<Object?> get props => [character];
}

class ShowingCharacterList extends HpCardState {
  final List<String> characterList;
  final Map<String, num> obtainedCharacters;

  ShowingCharacterList(this.characterList, this.obtainedCharacters);
  @override
  List<Object?> get props => [characterList, obtainedCharacters];
}

abstract class EstadoProblemaEsperado extends HpCardState {}

class ErrorInesperado extends EstadoProblemaEsperado {
  final Problem problem;

  ErrorInesperado(this.problem);

  @override
  List<Object?> get props => [problem];
}

class DataComunicatioError extends EstadoProblemaEsperado {
  final ProblemDataParse parseProblem;

  DataComunicatioError(this.parseProblem);

  @override
  List<Object?> get props => [parseProblem];
}

class BadCodeInput extends EstadoProblemaEsperado {
  final InvalidCode invalidCode;

  BadCodeInput(this.invalidCode);

  @override
  List<Object?> get props => [invalidCode];
}

abstract class UserInteraction extends HpCardState {}

class NoMatchForCharacterCode extends UserInteraction {
  @override
  List<Object?> get props => [];
}
