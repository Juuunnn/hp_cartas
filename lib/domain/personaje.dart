import 'dart:io';

import 'package:hp_cartas/domain/problem.dart';

class PersonajeHP {
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

  PersonajeHP._(
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

  factory PersonajeHP.constructor({
    required String nombre,
    required String especie,
    required String genero,
    String? casa,
    String? fechaNacimiento,
    String? ancestry,
    String? patronus,
    Barita? barita,
    required bool estudiante,
    required bool profesor,
    String? direccionImagen,
  }) {
    if (nombre.trim().isEmpty) {
      throw NombreInvalido();
    }
    if (especie.trim().isEmpty) {
      throw EspecieInvalido();
    }
    if (genero.trim().isEmpty) {
      throw GeneroInvalido();
    }
    return PersonajeHP._(
      nombre,
      especie,
      casa ?? 'n/a',
      genero,
      fechaNacimiento ?? 'n/a',
      ancestry ?? 'n/a',
      patronus ?? 'n/a',
      barita,
      estudiante,
      profesor,
      direccionImagen != null ? Uri.parse(direccionImagen) : null,
    );
  }
}

class Barita {
  final String wood;
  final String core;
  final int length;

  Barita({required this.wood, required this.core, required this.length});
}
