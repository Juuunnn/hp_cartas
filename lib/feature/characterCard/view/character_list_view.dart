// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CharacterListView extends StatelessWidget {
  const CharacterListView(
      {super.key,
      required this.characterList,
      required this.onClick,
      required this.obtainedCharacters});
  final List<String> characterList;
  final List<String> obtainedCharacters;
  final Function(String characterName) onClick;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: CharacterList(
        fullCharacterList: characterList,
        onClick: onClick,
        obtainedCharacters: obtainedCharacters,
      ),
    );
  }
}

class CharacterList extends StatelessWidget {
  const CharacterList({
    Key? key,
    required this.fullCharacterList,
    required this.onClick,
    required this.obtainedCharacters,
  }) : super(key: key);

  final List<String> fullCharacterList;
  final List<String> obtainedCharacters;
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
            children: fullCharacterList
                .map(
                  (e) => TableRow(
                    children: [
                      CharacterEntry(
                        obtainedCharacters: obtainedCharacters,
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
    required this.obtainedCharacters,
  }) : super(key: key);
  final String characterName;
  final List<String> obtainedCharacters;
  final Function(String characterName) onClick;

  @override
  Widget build(BuildContext context) {
    bool obtained = obtainedCharacters.contains(characterName);
    return TextButton(
      style: TextButton.styleFrom(
          backgroundColor: obtained ? Colors.brown[300] : null,
          foregroundColor: Colors.black),
      onPressed: obtained ? () => onClick(characterName) : null,
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
