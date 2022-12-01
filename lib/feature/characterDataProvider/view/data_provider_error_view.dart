import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hp_cartas/domain/problem.dart';
import 'package:hp_cartas/feature/characterDataProvider/component/bad_comunication_component.dart';
import 'package:hp_cartas/feature/characterDataProvider/component/invalid_data_recived_component.dart';

class DataProviderErrorView extends StatelessWidget {
  const DataProviderErrorView({super.key, required this.data});

  final ProblemDataParse data;

  @override
  Widget build(BuildContext context) {
    if (data is InvalidDataRecived) {
      return const InvalidDataRecivedComponent();
    }
    if (data is BadAPIConection) {
      return const BadComunicationComponent();
    }
    return const Center(
      child: Text('si ves esto llama al desarrollador'),
    );
  }
}
