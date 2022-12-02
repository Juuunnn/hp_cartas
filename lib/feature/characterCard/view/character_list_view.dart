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
  final Map<String, num> obtainedCharacters;
  final Function(String characterName) onClick;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      CharacterCounter(
          totalCharacters: characterList.toSet().length,
          currentCharacters: obtainedCharacters.entries.toSet().length),
      SingleChildScrollView(
        child: CharacterList(
          fullCharacterList: characterList,
          onClick: onClick,
          obtainedCharacters: obtainedCharacters,
        ),
      ),
    ]);
  }
}

class CharacterCounter extends StatelessWidget {
  const CharacterCounter({
    Key? key,
    required this.totalCharacters,
    required this.currentCharacters,
  }) : super(key: key);
  final int totalCharacters;
  final int currentCharacters;
  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: 60,
        top: 20,
        child: Text('$currentCharacters / $totalCharacters'));
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
  final Map<String, num> obtainedCharacters;
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
  final Map<String, num> obtainedCharacters;
  final Function(String characterName) onClick;

  @override
  Widget build(BuildContext context) {
    bool obtained = obtainedCharacters.keys.contains(characterName);
    return TextButton(
      style: TextButton.styleFrom(
          backgroundColor: obtained ? Colors.brown[300] : null,
          foregroundColor: Colors.black),
      onPressed: obtained ? () => onClick(characterName) : null,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Row(
            children: [
              Text(
                characterName,
                style: GoogleFonts.aladin(fontSize: 30),
              ),
              Spacer(),
              Text(
                obtained ? obtainedCharacters[characterName].toString() : '',
                style: GoogleFonts.aladin(fontSize: 30, color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
