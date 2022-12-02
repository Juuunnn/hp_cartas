import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_cartas/bloc/hp_card_bloc.dart';
import 'package:hp_cartas/domain/code_input.dart';
import 'package:hp_cartas/feature/characterCard/character_repo.dart';
import 'package:hp_cartas/feature/characterCard/view/bad_code_input.dart';
import 'package:hp_cartas/feature/characterCard/view/character_card_view.dart';
import 'package:hp_cartas/feature/characterCard/view/character_list_view.dart';
import 'package:hp_cartas/feature/characterCard/view/character_obtainer_view.dart';
import 'package:hp_cartas/feature/characterDataProvider/view/data_provider_error_view.dart';
import 'package:hp_cartas/feature/characterDataProvider/view/new_character_obtained_view.dart';
import 'package:hp_cartas/genericView/bad_state_view.dart';
import 'package:hp_cartas/genericView/loading.dart';
import 'package:hp_cartas/genericView/unexpected_error_view.dart';

const String apiUrl = 'test';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HpCardBloc.tester(apiUrl: apiUrl),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.brown,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Flutter Demo Home Page'),
          ),
          body: const Pantalla(),
        ),
      ),
    );
  }
}

class Pantalla extends StatelessWidget {
  const Pantalla({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HpCardBloc, HpCardState>(
      builder: (context, state) {
        if (state is HpCardInitial) {
          // context.read<HpCardBloc>().add(NavegatedToCharacterList());
          return const Loading();
        }
        if (state is LoadingData) {
          return const Loading();
        }
        if (state is ShowingCharacterCard) {
          return CharacterCardView(
            character: state.character,
            onReturn: () {
              context.read<HpCardBloc>().add(NavegatedToCharacterList());
            },
          );
        }
        if (state is ShowingCharacterList) {
          return Stack(children: [
            CharacterListView(
              characterList: state.characterList,
              onClick: (String characterName) {
                context
                    .read<HpCardBloc>()
                    .add(SelectedCharacterCard(characterName: characterName));
              },
              obtainedCharacters: state.obtainedCharacters,
            ),
            CharacterObtainerView(onSend: (CodeInput code) {
              context.read<HpCardBloc>().add(InputedCharacterCode(code));
            }),
          ]);
        }
        if (state is ShowingNewCharacterObtained) {
          return NewCharacterObtainedView(
            character: state.character,
            onTap: () {
              context.read<HpCardBloc>().add(NavegatedToCharacterList());
            },
          );
        }
        if (state is ErrorInesperado) {
          return UnexpectedErrorView(problem: state.problem);
        }
        if (state is DataComunicatioError) {
          return DataProviderErrorView(data: state.parseProblem);
        }
        if (state is UserInteraction) {
          return BadCodeInputView(
            data: state,
            onClick: () {
              context.read<HpCardBloc>().add(NavegatedToCharacterList());
            },
          );
        }
        return const BadStateView();
      },
    );
  }
}
