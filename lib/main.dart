import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hp_cartas/feature/characterCard/character_card_repo.dart';
import 'package:hp_cartas/feature/characterCard/view/character_card_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}

class Pantalla extends StatelessWidget {
  const Pantalla({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CharacterCardRepo repo = CharacterCardRepoTest();
    final resultado = repo.getCharacterData(characterName: 'Harry Potter');

    return Center(
        child: resultado.match(
      (l) => const Text('personaje no encontrado'),
      (r) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CharacterCardView(character: r),
        ],
      ),
    ));
  }
}
