import 'package:flutter/material.dart';
import 'package:fractals/fractals/fractals.dart';

import 'play.dart';

class GameSelection extends StatelessWidget {
  const GameSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              FractalChooser(Type.na),
              FractalChooser(Type.fern),
              FractalChooser(Type.julia),
              FractalChooser(Type.triangle),
              FractalChooser(Type.square0),
              FractalChooser(Type.square1),
              FractalChooser(Type.square2),
              FractalChooser(Type.pentagon),
            ],
          ),
        ),
      ),
    );
  }
}

class FractalChooser extends StatelessWidget {
  final Type type;
  const FractalChooser(this.type, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PlayView(type),
            ),
          );
        },
        child: Text(type.toString().split('.').last),
      ),
    );
  }
}
