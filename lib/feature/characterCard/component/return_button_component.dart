import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

class ReturnButton extends StatelessWidget {
  const ReturnButton({
    Key? key,
    required this.onReturn,
  }) : super(key: key);

  final Function() onReturn;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 60,
      bottom: 40,
      child: FloatingActionButton.extended(
        onPressed: onReturn,
        label: const Text('return'),
        icon: const Icon(Icons.arrow_back),
      ),
    );
  }
}
