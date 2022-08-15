import 'package:flutter/material.dart';
import 'package:fractals/fractals/fractals.dart';

import 'play.dart';

class GameSelection extends StatelessWidget {
  const GameSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            FractalChooser(Type.triangle),
            FractalChooser(Type.julia),
            FractalChooser(Type.square0),
            FractalChooser(Type.square1),
            FractalChooser(Type.square2),
            FractalChooser(Type.pentagon),
          ],
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
