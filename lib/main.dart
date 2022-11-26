import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_cartas/bloc/hp_card_bloc.dart';
import 'package:hp_cartas/feature/characterCard/character_card_repo.dart';
import 'package:hp_cartas/feature/characterCard/view/character_card_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HpCardBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
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
          context
              .read<HpCardBloc>()
              .add(SelectedCharacterCard(characterName: 'Harry Potter'));
        }
        if (state is ShowingCharacterCard) {
          return CharacterCardView(character: state.character);
        }
        if (state is ErrorInesperado) {}
        return const Text('esperando');
      },
    );
  }
}
