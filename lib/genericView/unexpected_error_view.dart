import 'package:flutter/widgets.dart';
import 'package:hp_cartas/domain/problem.dart';

class UnexpectedErrorView extends StatelessWidget {
  const UnexpectedErrorView({super.key, required this.problem});
  final Problem problem;
  @override
  Widget build(BuildContext context) {
    // print(object)
    if (problem is UnknownProblem) {
      return Center(
        child: Column(
          children: [
            const Text('se genero un error inesperado en la aplicacion:'),
            Text(
                'Estado actual ${problem.toString()} ${(problem as UnknownProblem).problema}'),
            // TODO: aqui deve haber alguna manera para reiniciar la aplicacion
          ],
        ),
      );
    }
    return Center(
      child: Column(
        children: [
          const Text('se genero un error inesperado en la aplicacion:'),
          Text('Estado actual ${problem.toString()}'),
          // TODO: aqui deve haber alguna manera para reiniciar la aplicacion
        ],
      ),
    );
  }
}
