import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hp_cartas/domain/character.dart';

class CharacterCardView extends StatelessWidget {
  const CharacterCardView({super.key, required this.character});
  final HPCharacter character;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(character.name),
        CachedNetworkImage(
          imageUrl: character.image ??
              'https://via.placeholder.com/728x90.jpeg?text=No+Image+data',
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Text(character.ancestry),
        Text(character.dateOfBirth),
        Text(character.gender),
        Text(character.house),
        Text(character.patronus),
        Text(character.species),
        Text(character.hogwartsStaff.toString()),
        Text(character.hogwartsStudent.toString()),
        WandaInfo(wand: character.wand),
      ],
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
