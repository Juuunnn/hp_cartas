part of 'hp_card_bloc.dart';

@immutable
abstract class HpCardEvent {}

class SelectedCharacterCard extends HpCardEvent {}

class NavegatedToCharacterList extends HpCardEvent {}
