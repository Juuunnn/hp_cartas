import 'dart:io';

import 'package:hp_cartas/domain/problem.dart';

class HPCharacter {
  final String name;
  final String species;
  final String house;
  final String gender;
  final String dateOfBirth;
  final String ancestry;
  final String patronus;
  final Barita? wand;
  final bool hogwartsStudent;
  final bool hogwartsStaff;
  final Uri? image;

  HPCharacter._(
      this.name,
      this.species,
      this.house,
      this.gender,
      this.dateOfBirth,
      this.ancestry,
      this.patronus,
      this.wand,
      this.hogwartsStudent,
      this.hogwartsStaff,
      this.image);

  factory HPCharacter.constructor({
    required String nameProp,
    required String speciesProp,
    required String genderProp,
    String? houseProp,
    String? dateOfBirthProp,
    String? ancestryProp,
    String? patronusProp,
    Barita? wandProp,
    required bool hogwartsStudentProp,
    required bool hogwartsStaffProp,
    String? imageUrl,
  }) {
    if (nameProp.trim().isEmpty) throw InvalidName();
    if (speciesProp.trim().isEmpty) throw InvalidSpecies();
    if (genderProp.trim().isEmpty) throw InvalidGender();
    if (imageUrl != null) {
      if (!Uri.parse(imageUrl).isAbsolute) throw InvalidImageUrl();
    }

    return HPCharacter._(
      nameProp,
      speciesProp,
      houseProp ?? 'n/a',
      genderProp,
      dateOfBirthProp ?? 'n/a',
      ancestryProp ?? 'n/a',
      patronusProp ?? 'n/a',
      wandProp,
      hogwartsStudentProp,
      hogwartsStaffProp,
      imageUrl != null ? Uri.parse(imageUrl) : null,
    );
  }
}

class Barita {
  final String wood;
  final String core;
  final int length;

  Barita({required this.wood, required this.core, required this.length});
}
