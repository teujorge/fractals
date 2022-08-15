import 'package:flutter/material.dart';

import 'dart:async';

import 'fractals/fractals.dart';
import 'fractals/triangles.dart';
import 'fractals/fern.dart';
import 'fractals/squares.dart';
import 'fractals/pentagons.dart';

class PlayView extends StatefulWidget {
  final Type type;
  const PlayView(
    this.type, {
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => PlayViewState();
}

class PlayViewState extends State<PlayView> {
  late final FractalPainter painter;
  late final SpeedSlider slider;
  late Timer timer;

  List<Offset> points = [];

  @override
  void initState() {
    super.initState();

    painter = whichFractalPainter(context);

    timer = Timer.periodic(
      const Duration(microseconds: 1),
      ((Timer timer) {
        setState(() {});
      }),
    );

    slider = SpeedSlider();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  FractalPainter whichFractalPainter(BuildContext context) {
    switch (widget.type) {
      case Type.triangle:
        return TriangleFractalPainter(0);

      case Type.fern:
        return FernFractalPainter(0);

      case Type.square0:
        return SquareFractalPainter(0);

      case Type.square1:
        return SquareFractalPainter(1);

      case Type.square2:
        return SquareFractalPainter(2);

      case Type.pentagon:
        return PentagonFractalPainter(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (painter.vertices.isNotEmpty) {
      if (painter.points.length < 50000) {
        for (int i = 0; i < slider.value; i++) {
          painter.makeDots();
        }
      } else {
        timer.cancel();
      }
    }

    return MaterialApp(
      home: Scaffold(
        body: LayoutBuilder(
          builder: (_, constraints) {
            return Container(
              color: Colors.black,
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: Stack(
                children: [
                  CustomPaint(
                    painter: painter
                      ..screenSize = Size(
                        constraints.maxWidth,
                        constraints.maxHeight,
                      ),
                  ),
                  Positioned(
                    right: 15,
                    bottom: 10,
                    child: slider,
                  ),
                  Positioned(
                    right: 10,
                    bottom: 215,
                    child: Text(
                      "Speed: x${slider.value.round()}",
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ),
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
                  Positioned(
                    left: 10,
                    top: 40,
                    child: Text(
                      "Dots: ${painter.points.length}",
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class SpeedSlider extends StatefulWidget {
  double value = 1;

  SpeedSlider({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => SpeedSliderState();
}

class SpeedSliderState extends State<SpeedSlider> {
  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: -1,
      child: Container(
        width: 200,
        height: 50,
        color: Colors.grey.withAlpha(100),
        child: Slider(
          min: 0,
          max: 100,
          value: widget.value,
          onChanged: (value) {
            setState(() {
              widget.value = value;
            });
          },
        ),
      ),
    );
  }
}
