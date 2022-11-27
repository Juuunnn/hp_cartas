// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CharacterListView extends StatelessWidget {
  const CharacterListView(
      {super.key, required this.characterList, required this.onClick});
  final List<String> characterList;
  final Function(String characterName) onClick;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: CharacterList(characterList: characterList, onClick: onClick),
    );
  }
}

class CharacterList extends StatelessWidget {
  const CharacterList({
    Key? key,
    required this.characterList,
    required this.onClick,
  }) : super(key: key);

  final List<String> characterList;
  final Function(String characterName) onClick;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 400,
        child: Table(
            border: TableBorder.symmetric(
              outside: const BorderSide(color: Colors.black),
              inside: const BorderSide(color: Colors.black),
            ),
            children: characterList
                .map(
                  (e) => TableRow(
                    children: [
                      CharacterEntry(
                        characterName: e,
                        onClick: onClick,
                      ),
                    ],
                  ),
                )
                .toList()),
      ),
    );
  }
}

class CharacterEntry extends StatelessWidget {
  const CharacterEntry({
    Key? key,
    required this.characterName,
    required this.onClick,
  }) : super(key: key);
  final String characterName;
  final Function(String characterName) onClick;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onClick(characterName),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            characterName,
            style: GoogleFonts.aladin(fontSize: 30),
          ),
        ),
      ),
    );
  }
}
