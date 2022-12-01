import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class BadComunicationComponent extends StatelessWidget {
  const BadComunicationComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('mala comunicacion con servidor'),
    );
  }
}
