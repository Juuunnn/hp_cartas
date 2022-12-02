import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hp_cartas/domain/problem.dart';

class UnexpectedErrorView extends StatelessWidget {
  const UnexpectedErrorView(
      {super.key, required this.problem, required this.onClick});
  final Problem problem;
  final Function() onClick;
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
            TextButton(
              onPressed: onClick,
              child: const Text('volver a iniciar la aplicacion'),
            )
          ],
        ),
      );
    }
    return Center(
      child: Column(
        children: [
          const Text('se genero un error inesperado en la aplicacion:'),
          Text('Estado actual ${problem.toString()}'),
          TextButton(
            onPressed: onClick,
            child: const Text('volver a iniciar la aplicacion'),
          )
        ],
      ),
    );
  }
}
