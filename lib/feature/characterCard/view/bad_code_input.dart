import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hp_cartas/bloc/hp_card_bloc.dart';

class BadCodeInputView extends StatelessWidget {
  const BadCodeInputView(
      {super.key, required this.data, required this.onClick});
  final UserInteraction data;
  final Function() onClick;
  @override
  Widget build(BuildContext context) {
    Widget message = const Text('si ves esto llama al desarrollador');
    if (data is NoMatchForCharacterCode) {
      message = const NoMatchForCharacterCodeComponent();
    }
    if (data is BadCodeInput) {
      message = const BadCodeInputComponent();
    }
    return Center(
      child: Column(
        children: [
          message,
          TextButton(
            onPressed: onClick,
            child: const Text('volver'),
          ),
        ],
      ),
    );
  }
}

class NoMatchForCharacterCodeComponent extends StatelessWidget {
  const NoMatchForCharacterCodeComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('no se encontro ningun personaje con ese codigo'),
    );
  }
}

class BadCodeInputComponent extends StatelessWidget {
  const BadCodeInputComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('no se encontro ningun personaje con ese codigo'),
    );
  }
}
