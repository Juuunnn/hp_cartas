import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hp_cartas/domain/character.dart';
import 'package:hp_cartas/feature/characterCard/component/character_card_component.dart';

class CharacterCardView extends StatelessWidget {
  const CharacterCardView(
      {super.key, required this.character, required this.onReturn});
  final HPCharacter character;
  final Function() onReturn;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      CharacterCard(character: character),
      ReturnButton(onReturn: onReturn),
    ]);
  }
}

class ReturnButton extends StatelessWidget {
  const ReturnButton({
    Key? key,
    required this.onReturn,
  }) : super(key: key);

  final Function() onReturn;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      widthFactor: 50,
      heightFactor: 50,
      child: FloatingActionButton.extended(
        onPressed: onReturn,
        label: const Text('return'),
        icon: const Icon(Icons.arrow_back),

        // elevation: 8,
      ),
    );
  }
}
