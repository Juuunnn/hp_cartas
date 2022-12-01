import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hp_cartas/domain/character.dart';
import 'package:hp_cartas/domain/spell.dart';

class CharacterCardComponent extends StatelessWidget {
  const CharacterCardComponent({
    Key? key,
    required this.character,
    required this.spellList,
  }) : super(key: key);

  final HPCharacter character;
  final List<Spell> spellList;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> characterMap = jsonDecode(character.toJson());
    //[ ]: ahora puedo agregar campos a character y siempre y cuando sean de tipo
    // string estos se agregaran como su propio espacio en la tarjeta
    characterMap.removeWhere((key, value) =>
        [
          'name',
          'image',
        ].contains(key) ||
        value is! String);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 231, 203, 138),
              border: Border.all(color: Colors.grey, width: 2),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(7.0),
              child: SizedBox(
                width: 300,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      color: Colors.brown,
                      child: Center(
                        child: Text(
                          character.name,
                          style: GoogleFonts.aladin(fontSize: 30),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CachedNetworkImage(
                        imageUrl: character.image ??
                            'https://via.placeholder.com/728x90.jpeg?text=No+Image+data',
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Table(
                        // defaultColumnWidth: const FlexColumnWidth(100),
                        border: TableBorder.symmetric(
                          outside: const BorderSide(color: Colors.black),
                          inside: const BorderSide(color: Colors.black),
                        ),
                        children: [
                          ...characterMap.entries.map((e) {
                            return TableRow(children: [
                              CampoTabla(e.key),
                              RegistroTabla(e.value),
                            ]);
                          }).toList(),
                          TableRow(children: [
                            const CampoTabla('hogwartsStaff'),
                            RegistroTabla(character.hogwartsStaff.toString()),
                          ]),
                          TableRow(children: [
                            const CampoTabla('hogwartsStudent'),
                            RegistroTabla(character.hogwartsStudent.toString()),
                          ]),
                          TableRow(children: [
                            const CampoTabla('wand'),
                            WandaInfo(wand: character.wand),
                          ]),
                          TableRow(children: [
                            const CampoTabla('coigo'),
                            RegistroTabla(character.hashCode.toString()),
                          ]),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RegistroTabla extends StatelessWidget {
  const RegistroTabla(
    this.nombreCampo, {
    Key? key,
  }) : super(key: key);
  final String nombreCampo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(nombreCampo),
      ),
    );
  }
}

class CampoTabla extends StatelessWidget {
  const CampoTabla(
    this.nombreCampo, {
    Key? key,
  }) : super(key: key);
  final String nombreCampo;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(nombreCampo),
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
    if (wand == null || wand == Barita.vacia()) {
      return const Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Text('no tiene varita'),
        ),
      );
    }
    return Column(
      children: [
        Text(wand!.wood),
        Text(wand!.core),
        Text(wand?.length.toString() ?? 'n/a'),
      ],
    );
  }
}
