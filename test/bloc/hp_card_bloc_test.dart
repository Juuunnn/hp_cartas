import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hp_cartas/bloc/hp_card_bloc.dart';

void main() {
  group('hp card bloc debe', () {
    blocTest<HpCardBloc, HpCardState>(
      'deve poder mostrar la tarjeta de un personaje',
      build: () => HpCardBloc(),
      act: (bloc) => bloc.add(SelectedCharacterCard()),
      expect: () => [isA<ShowingCharacterCard>()],
    );
    blocTest<HpCardBloc, HpCardState>(
      'deve poder mostrar la lista de personajes ',
      build: () => HpCardBloc(),
      act: (bloc) => bloc.add(NavegatedToCharacterList()),
      expect: () => [isA<ShowingCharacterList>()],
    );
  });
}
