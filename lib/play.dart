import 'package:flutter/material.dart';
import 'package:flame/game.dart';

import 'fractals/fractals.dart';
import 'fractals/triangles.dart';
import 'fractals/squares.dart';
import 'fractals/pentagons.dart';

class GamePlay extends StatelessWidget {
  late Fractals game;
  final Type type;
  GamePlay(
    this.type, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case Type.triangle:
        game = TriangleFractal(context, 0);
        break;
      case Type.square0:
        game = SquareFractal(context, 0);
        break;
      case Type.square1:
        game = SquareFractal(context, 1);
        break;
      case Type.square2:
        game = SquareFractal(context, 2);
        break;
      case Type.pentagon:
        game = PentagonFractal(context, 0);
        break;
    }

    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            GameWidget(game: game),
            SpeedSlider(game: game),
            Positioned(
              left: 10,
              top: 10,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("back"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SpeedSlider extends StatefulWidget {
  final Fractals game;
  const SpeedSlider({
    Key? key,
    required this.game,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => SpeedSliderState();
}

class SpeedSliderState extends State<SpeedSlider> {
  double sliderValue = 1;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 10,
      bottom: 10,
      child: RotatedBox(
        quarterTurns: -1,
        child: Container(
          width: 200,
          height: 50,
          color: Colors.grey.withAlpha(100),
          child: Slider(
            min: 0,
            max: 100,
            divisions: 20,
            value: sliderValue,
            onChanged: (value) {
              setState(() {
                widget.game.dotSpeed = value.round();
                sliderValue = value;
              });
            },
          ),
        ),
      ),
    );
  }
}
