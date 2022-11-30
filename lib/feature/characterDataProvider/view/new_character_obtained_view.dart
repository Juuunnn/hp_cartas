import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../domain/character.dart';

class NewCharacterObtainedView extends StatelessWidget {
  const NewCharacterObtainedView(
      {super.key, required this.character, required this.onTap});
  final HPCharacter character;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 231, 203, 138),
            border: Border.all(color: Colors.grey, width: 2),
            borderRadius: BorderRadius.circular(8.0),
          ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
