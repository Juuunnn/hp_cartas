import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:fpdart/fpdart.dart' show Either, left, right;
import 'package:hp_cartas/domain/code_input.dart';
import 'package:hp_cartas/domain/problem.dart';

import 'bad_code_input.dart';

class CharacterObtainerView extends StatelessWidget {
  const CharacterObtainerView({super.key, required this.onSend});
  final void Function(CodeInput) onSend;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 60,
      top: 60,
      child: ElevatedButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return InputCodeForm(onSend: onSend);
              });
        },
        child: const Text('buscar'),
      ),
    );
  }
}

class InputCodeForm extends StatefulWidget {
  const InputCodeForm({super.key, required this.onSend});
  final Function(CodeInput) onSend;

  @override
  State<InputCodeForm> createState() => _InputCodeFormState();
}

class _InputCodeFormState extends State<InputCodeForm> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = '123';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        backgroundColor: const Color.fromARGB(255, 231, 203, 138),
        title: Center(
          child: Container(
              // width: double.infinity,
              // height: double.infinity,
              decoration: const BoxDecoration(
                  // border: Border.all(color: Colors.grey, width: 2),
                  // color: Color.fromARGB(255, 231, 203, 138),
                  ),
              child:
                  const Text('Ingrese el codigo del personaje a desbloquear')),
        ),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                maxLength: 9,
                autofocus: true,
                keyboardType: TextInputType.number,
                controller: _controller,
                onSubmitted: (value) {
                  submitedCode(value, context);
                },
              ),
              TextButton(
                onPressed: () {
                  submitedCode(_controller.text, context);
                },
                child: Text('ingresar'.toUpperCase()),
              )
            ],
          ),
        ]);
  }

  void submitedCode(String value, BuildContext context) {
    codigo(value).match((l) {
      if (l is InvalidCode) {
        if (l is EmptyInput) {
          showToast('ingresa un codigo', context: context);
        } else if (l is IsNotNumber) {
          // else {
          showToast('solo ingresa numeros', context: context);
        }
      } else {
        showToast('si ves esto llama al desarrollador', context: context);

        // FlutterToast(context).showToast(
        //   child: Center(
        //     child: Column(
        //       children: const [
        //         Text('si ves esto llama al desarrollador'),
        //       ],
        //     ),
        //   ),
        // );
      }
    }, (r) {
      widget.onSend(r);
      Navigator.pop(context);
    });
  }
}

Either<Problem, CodeInput> codigo(String propCode) {
  try {
    return right(CodeInput.constructor(propCode));
  } on InvalidCode catch (e) {
    return left(e);
  } catch (e) {
    return left(UnknownProblem(e.toString()));
  }
}
