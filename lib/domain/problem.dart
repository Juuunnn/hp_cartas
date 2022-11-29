abstract class Problem {}

abstract class ProblemCharacter extends Problem {}

class InvalidName extends ProblemCharacter {}

class InvalidGender extends ProblemCharacter {}

class InvalidSpecies extends ProblemCharacter {}

class InvalidImageUrl extends ProblemCharacter {}

class UnknownProblem extends Problem {
  final String? problema;

  UnknownProblem(this.problema);
}

abstract class ProblemDataParse extends Problem {}

class InvalidDataRecived extends ProblemDataParse {}

class BadAPIConection extends ProblemDataParse {}
