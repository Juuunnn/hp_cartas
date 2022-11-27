import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_cartas/bloc/hp_card_bloc.dart';

class BadStateView extends StatelessWidget {
  const BadStateView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HpCardBloc, HpCardState>(
      builder: (context, state) {
        return Center(
          child: Column(
            children: [
              const Text('Un error catastrofico ocurrio:'),
              Text('Estado actual ${state.toString()}'),
              // TODO: aqui deve haber alguna manera para reiniciar la aplicacion
            ],
          ),
        );
      },
    );
  }
}
