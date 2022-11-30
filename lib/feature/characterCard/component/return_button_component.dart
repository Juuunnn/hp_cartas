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
    return Align(
      alignment: Alignment.bottomRight,
      child: Positioned(
        right: 20,
        bottom: 20,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 40.0, 20),
          child: FloatingActionButton.extended(
            onPressed: onReturn,
            label: const Text('return'),
            icon: const Icon(Icons.arrow_back),

            // elevation: 8,
          ),
        ),
      ),
    );
  }
}
