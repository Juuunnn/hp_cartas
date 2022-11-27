// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
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
  late final String? image;

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
    // if (imageUrl != null) {
    //   if (!Uri.parse(imageUrl).isAbsolute) throw InvalidImageUrl();
    // }

    return HPCharacter._(
      name: nameProp,
      species: speciesProp,
      house: isNotEmpty(houseProp),
      gender: genderProp,
      dateOfBirth: isNotEmpty(dateOfBirthProp),
      ancestry: isNotEmpty(ancestryProp),
      patronus: isNotEmpty(patronusProp),
      wand: wandProp,
      hogwartsStudent: hogwartsStudentProp,
      hogwartsStaff: hogwartsStaffProp,
      image: imageUrl != '' ? imageUrl : null,
    );
  }

  HPCharacter copyWith({
    String? name,
    String? species,
    String? house,
    String? gender,
    String? dateOfBirth,
    String? ancestry,
    String? patronus,
    Barita? wand,
    bool? hogwartsStudent,
    bool? hogwartsStaff,
    String? image,
  }) {
    return HPCharacter.constructor(
      nameProp: name ?? this.name,
      speciesProp: species ?? this.species,
      houseProp: house ?? this.house,
      genderProp: gender ?? this.gender,
      dateOfBirthProp: dateOfBirth ?? this.dateOfBirth,
      ancestryProp: ancestry ?? this.ancestry,
      patronusProp: patronus ?? this.patronus,
      wandProp: wand ?? this.wand,
      hogwartsStudentProp: hogwartsStudent ?? this.hogwartsStudent,
      hogwartsStaffProp: hogwartsStaff ?? this.hogwartsStaff,
      imageUrl: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'species': species,
      'house': house,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
      'ancestry': ancestry,
      'patronus': patronus,
      'wand': wand?.toMap(),
      'hogwartsStudent': hogwartsStudent,
      'hogwartsStaff': hogwartsStaff,
      'image': image,
    };
  }

  factory HPCharacter.fromMap(Map<String, dynamic> map) {
    return HPCharacter.constructor(
      nameProp: map['name'] as String,
      speciesProp: map['species'] as String,
      houseProp: map['house'] as String,
      genderProp: map['gender'] as String,
      dateOfBirthProp: map['dateOfBirth'] as String,
      ancestryProp: map['ancestry'] as String,
      patronusProp: map['patronus'] as String,
      wandProp: map['wand'] != null
          ? Barita.fromMap(map['wand'] as Map<String, dynamic>)
          : null,
      hogwartsStudentProp: map['hogwartsStudent'] as bool,
      hogwartsStaffProp: map['hogwartsStaff'] as bool,
      imageUrl: map['image'] != null ? map['image'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HPCharacter.fromJson(String source) =>
      HPCharacter.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HPCharacter(name: $name, species: $species, house: $house, gender: $gender, dateOfBirth: $dateOfBirth, ancestry: $ancestry, patronus: $patronus, wand: $wand, hogwartsStudent: $hogwartsStudent, hogwartsStaff: $hogwartsStaff, image: $image)';
  }

  @override
  bool operator ==(covariant HPCharacter other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.species == species &&
        other.house == house &&
        other.gender == gender &&
        other.dateOfBirth == dateOfBirth &&
        other.ancestry == ancestry &&
        other.patronus == patronus &&
        other.wand == wand &&
        other.hogwartsStudent == hogwartsStudent &&
        other.hogwartsStaff == hogwartsStaff &&
        other.image == image;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        species.hashCode ^
        house.hashCode ^
        gender.hashCode ^
        dateOfBirth.hashCode ^
        ancestry.hashCode ^
        patronus.hashCode ^
        wand.hashCode ^
        hogwartsStudent.hashCode ^
        hogwartsStaff.hashCode ^
        image.hashCode;
  }
}

class Barita {
  final String wood;
  final String core;
  final num? length;

  Barita({
    required this.wood,
    required this.core,
    required this.length,
  });
  Barita.vacia({
    this.wood = '',
    this.core = '',
    this.length,
  });

  Barita copyWith({
    String? wood,
    String? core,
    num? length,
  }) {
    return Barita(
      wood: wood ?? this.wood,
      core: core ?? this.core,
      length: length ?? this.length,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'wood': wood,
      'core': core,
      'length': length,
    };
  }

  factory Barita.fromMap(Map<String, dynamic> map) {
    return Barita(
      wood: map['wood'] as String,
      core: map['core'] as String,
      length: map['length'] != null ? map['length'] as num : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Barita.fromJson(String source) =>
      Barita.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Barita(wood: $wood, core: $core, length: $length)';

  @override
  bool operator ==(covariant Barita other) {
    if (identical(this, other)) return true;

    return other.wood == wood && other.core == core && other.length == length;
  }

  @override
  int get hashCode => wood.hashCode ^ core.hashCode ^ length.hashCode;
}

String isNotEmpty(String? string) {
  const defaultReturn = 'n/a';
  if (string == null) return defaultReturn;
  if (string.trim().isEmpty) return defaultReturn;
  return string;
}
