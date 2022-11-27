import 'package:flutter/material.dart';

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
      widthFactor: 50,
      heightFactor: 50,
      child: FloatingActionButton.extended(
        onPressed: onReturn,
        label: const Text('return'),
        icon: const Icon(Icons.arrow_back),

        // elevation: 8,
      ),
    );
  }
}
