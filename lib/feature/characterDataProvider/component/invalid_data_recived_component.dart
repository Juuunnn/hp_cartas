import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class InvalidDataRecivedComponent extends StatelessWidget {
  const InvalidDataRecivedComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child:
          Text('formato de datos desactualizados, contacta al desarrollador'),
    );
  }
}
