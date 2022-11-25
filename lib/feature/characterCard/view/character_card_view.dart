import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hp_cartas/domain/character.dart';

class CharacterCardView extends StatelessWidget {
  const CharacterCardView({super.key, required this.character});
  final HPCharacter character;
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> characterMap = jsonDecode(character.toJson());
    characterMap.removeWhere((key, value) => [
          'name',
          'wand',
          'hogwartsStaff',
          'hogwartsStudent',
          'image'
        ].contains(key));
    return SizedBox(
      width: 300,
      child: Column(
        children: [
          Text(character.name),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CachedNetworkImage(
              imageUrl: character.image ??
                  'https://via.placeholder.com/728x90.jpeg?text=No+Image+data',
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Table(
            // defaultColumnWidth: const FlexColumnWidth(100),
            border: TableBorder.symmetric(
              outside: const BorderSide(color: Colors.black),
              inside: const BorderSide(color: Colors.black),
            ),
            children: [
              ...characterMap.entries.map((e) {
                return TableRow(children: [
                  Text(e.key),
                  Center(child: Text(e.value.toString()))
                ]);
              }).toList(),
              TableRow(children: [
                const Text('hogwartsStaff'),
                Center(child: Text(character.hogwartsStaff.toString()))
              ]),
              TableRow(children: [
                const Text('hogwartsStudent'),
                Center(child: Text(character.hogwartsStudent.toString())),
              ]),
              TableRow(children: [
                const Text('wand'),
                WandaInfo(wand: character.wand),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}

class WandaInfo extends StatelessWidget {
  const WandaInfo({
    Key? key,
    required this.wand,
  }) : super(key: key);

  final Barita? wand;

  @override
  Widget build(BuildContext context) {
    if (wand != null) {
      return Column(
        children: [
          Text(wand!.wood),
          Text(wand!.core),
          Text(wand!.length.toString()),
        ],
      );
    }
    return const Text('no tiene varita');
  }
}
