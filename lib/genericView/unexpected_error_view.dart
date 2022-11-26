import 'package:flutter/widgets.dart';

class UnexpectedError extends StatelessWidget {
  const UnexpectedError({super.key, required this.errorMessage});
  final String errorMessage;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text('se genero un error inesperado en la aplicacion:'),
          Text('Estado actual $errorMessage'),
          // TODO: aqui deve haber alguna manera para reiniciar la aplicacion
        ],
      ),
    );
  }
}
