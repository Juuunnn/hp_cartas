// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class Problem {}

abstract class ProblemCharacter extends Problem {}

class InvalidName extends ProblemCharacter {}

class InvalidGender extends ProblemCharacter {}

class InvalidSpecies extends ProblemCharacter {}

class InvalidImageUrl extends ProblemCharacter {}

class UnknownProblem extends Problem {
  final String? problema;

  UnknownProblem(this.problema);

  @override
  String toString() => 'UnknownProblem(problema: $problema)';
}

abstract class ProblemDataParse extends Problem {}

class InvalidDataRecived extends ProblemDataParse {}

class BadAPIConection extends ProblemDataParse {}

abstract class InvalidCode extends Problem {}

class EmptyInput extends InvalidCode {}

class IsNotNumber extends InvalidCode {}
