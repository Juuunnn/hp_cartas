import 'dart:io';

class PersonajeHP {
  final String name;
  final String species;
  final String? house;
  final String gender;
  final String? dateOfBirth;
  final String? ancestry;
  final String? patronus;
  final Map<String, Object>? wand;
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
    required String casa,
    required String genero,
    required String fechaNacimiento,
    required String ancestry,
    required String patronus,
    required Map<String, Object> barita,
    required String estudiante,
    required String profesor,
    required String direccionImagen,
  }) {
    throw UnimplementedError();
    // return PersonajeHP._(
    //   nombre,
    //   especie,
    //   casa,
    //   genero,
    //   fechaNacimiento,
    //   ancestry,
    //   patronus,
    //   barita,
    //   estudiante,
    //   profesor,
    //   direccionImagen,
    // );
  }
}
