// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'hp_card_bloc.dart';

@immutable
abstract class HpCardEvent {}

class SelectedCharacterCard extends HpCardEvent {
  final String characterName;

  SelectedCharacterCard({required this.characterName});

  @override
  bool operator ==(covariant SelectedCharacterCard other) {
    if (identical(this, other)) return true;

    return other.characterName == characterName;
  }

  @override
  int get hashCode => characterName.hashCode;
}

class NavegatedToCharacterList extends HpCardEvent {}

class StartedLoadingData extends HpCardEvent {
  final String apiUrl;

  StartedLoadingData({required this.apiUrl});
}
