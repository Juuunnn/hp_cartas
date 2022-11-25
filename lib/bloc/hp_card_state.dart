part of 'hp_card_bloc.dart';

@immutable
abstract class HpCardState {}

class HpCardInitial extends HpCardState {}

class ShowingCharacterCard extends HpCardState {}

class ShowingCharacterList extends HpCardState {}
