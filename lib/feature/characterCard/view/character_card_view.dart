import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hp_cartas/domain/character.dart';
import 'package:hp_cartas/feature/characterCard/component/character_card_component.dart';

import '../component/return_button_component.dart';

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
