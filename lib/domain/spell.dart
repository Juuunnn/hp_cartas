import 'dart:convert';

class Spell {
  final String name;
  final String description;
  Spell({
    required this.name,
    required this.description,
  });

  Spell copyWith({
    String? name,
    String? description,
  }) {
    return Spell(
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
    };
  }

  factory Spell.fromMap(Map<String, dynamic> map) {
    return Spell(
      name: map['name'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Spell.fromJson(String source) =>
      Spell.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Spell(name: $name, description: $description)';

  @override
  bool operator ==(covariant Spell other) {
    if (identical(this, other)) return true;

    return other.name == name && other.description == description;
  }

  @override
  int get hashCode => name.hashCode ^ description.hashCode;
}
