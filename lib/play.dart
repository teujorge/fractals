import 'package:flutter/material.dart';
import 'package:flame/game.dart';

import 'fractals/fractals.dart';
import 'fractals/triangles.dart';
import 'fractals/squares.dart';
import 'fractals/pentagons.dart';

class GamePlay extends StatelessWidget {
  final Type type;
  const GamePlay(
    this.type, {
    Key? key,
  }) : super(key: key);

  Fractals whichFractal(BuildContext context) {
    switch (type) {
      case Type.triangle:
        return TriangleFractal(context, 0);

      case Type.square0:
        return SquareFractal(context, 0);

      case Type.square1:
        return SquareFractal(context, 1);

      case Type.square2:
        return SquareFractal(context, 2);

      case Type.pentagon:
        return PentagonFractal(context, 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Fractals game = whichFractal(context);

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
