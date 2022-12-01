import 'package:flutter/material.dart';

class CharacterObtainerView extends StatelessWidget {
  const CharacterObtainerView({super.key, required this.onSend});
  final void Function(String) onSend;
  @override
  Widget build(BuildContext context) {
    final help = onSend;
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
  final Function(String) onSend;

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
                  widget.onSend(value);
                  Navigator.pop(context);
                },
              ),
              TextButton(
                onPressed: () {
                  widget.onSend(_controller.text);
                  Navigator.pop(context);
                },
                child: Text('ingresar'.toUpperCase()),
              )
            ],
          ),
        ]);
  }
}
