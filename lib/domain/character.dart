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
  final String? image;

  HPCharacter._(
      {required this.name,
      required this.species,
      required this.house,
      required this.gender,
      required this.dateOfBirth,
      required this.ancestry,
      required this.patronus,
      this.wand,
      required this.hogwartsStudent,
      required this.hogwartsStaff,
      this.image});

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
      name: nameProp,
      species: speciesProp,
      house: houseProp ?? 'n/a',
      gender: genderProp,
      dateOfBirth: dateOfBirthProp ?? 'n/a',
      ancestry: ancestryProp ?? 'n/a',
      patronus: patronusProp ?? 'n/a',
      wand: wandProp,
      hogwartsStudent: hogwartsStudentProp,
      hogwartsStaff: hogwartsStaffProp,
      image: imageUrl,
    );
  }
}

class Barita {
  final String wood;
  final String core;
  final int length;

  Barita({required this.wood, required this.core, required this.length});
}
