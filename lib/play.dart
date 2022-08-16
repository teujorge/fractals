import 'package:flutter/material.dart';

import 'dart:async';

import 'fractals/fractals.dart';
import 'fractals/interactiveFractals.dart';
import 'fractals/triangles.dart';
import 'fractals/fern.dart';
import 'fractals/julia.dart';
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
  List<Widget> draggables = [];
  late Timer timer;

  void clearPoints() {
    painter.points = [painter.points[painter.points.length - 1]];
  }

  void clearVertices() {
    painter.vertices = [];
  }

  void changeMidPoint(int num, int den) {
    painter.numerator = num;
    painter.denominator = den;
  }

  void createDraggableVertices() {
    draggables = [];
    for (Offset o in painter.vertices) {
      draggables.add(DraggableVertex(o));
    }
  }

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
        return TriangleFractalPainter();

      case Type.fern:
        return FernFractalPainter();

      case Type.julia:
        return JuliaFractalPainter();

      case Type.square0:
        return SquareFractalPainter();

      case Type.square1:
        return SquareFractalPainter(mode: 1);

      case Type.square2:
        return SquareFractalPainter(mode: 2);

      case Type.pentagon:
        return PentagonFractalPainter();

      case Type.na:
        return InteractiveFractalPainter();
    }
  }

  @override
  Widget build(BuildContext context) {
    // new points
    if (painter.vertices.isNotEmpty) {
      if (painter.points.length < 50000) {
        for (int i = 0; i < slider.value; i++) {
          painter.makeDots();
        }
      }
    }

    // controls
    final List<Widget> interactiveControls = [
      ElevatedButton(
        onPressed: () {
          painter.numVertices = 0;
          clearPoints();
          clearVertices();
          createDraggableVertices();
        },
        child: const Text("clear"),
      ),
      ElevatedButton(
        onPressed: () {
          painter.numVertices = 3;
          clearPoints();
          clearVertices();
          painter.paintVerticesTriangle();
          createDraggableVertices();
        },
        child: const Text("triangle"),
      ),
      ElevatedButton(
        onPressed: () {
          painter.numVertices = 4;
          clearPoints();
          clearVertices();
          painter.paintVerticesSquare();
          createDraggableVertices();
        },
        child: const Text("square"),
      ),
      ElevatedButton(
        onPressed: () {
          painter.numVertices = 5;
          clearPoints();
          clearVertices();
          painter.paintVerticesPentagon();
          createDraggableVertices();
        },
        child: const Text("pentagon"),
      ),
      ElevatedButton(
        onPressed: () {
          painter.numerator = 1;
          painter.denominator = 3;
          clearPoints();
        },
        child: const Text("1/3"),
      ),
      ElevatedButton(
        onPressed: () {
          painter.numerator = 1;
          painter.denominator = 2;
          clearPoints();
        },
        child: const Text("1/2"),
      ),
      ElevatedButton(
        onPressed: () {
          painter.numerator = 2;
          painter.denominator = 3;
          clearPoints();
        },
        child: const Text("2/3"),
      ),
      ElevatedButton(
        onPressed: () {
          painter.mode = 0;
          clearPoints();
        },
        child: const Text("allow same vertex"),
      ),
      ElevatedButton(
        onPressed: () {
          painter.mode = 1;
          clearPoints();
        },
        child: const Text("no allow same vertex"),
      ),
    ];

    if (widget.type == Type.na) {
      for (int i = 0; i < painter.vertices.length; i++) {
        if ((draggables[i] as DraggableVertex).doneDragging) {
          clearPoints();
          Offset newPercentage = (draggables[i] as DraggableVertex).offset;
          painter.verticesP[i] = Offset(
            newPercentage.dx / MediaQuery.of(context).size.width,
            newPercentage.dy / MediaQuery.of(context).size.height,
          );
          (draggables[i] as DraggableVertex).doneDragging = false;
        }
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
                children: draggables +
                    [
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
                      widget.type == Type.na
                          ? Positioned(
                              child: MediaQuery.of(context).size.width > 1000
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: interactiveControls,
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: interactiveControls,
                                    ),
                            )
                          : const SizedBox(),
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

class DraggableVertex extends StatefulWidget {
  Offset offset;
  bool doneDragging = false;

  late double width;
  late double height;

  DraggableVertex(
    this.offset, {
    Key? key,
    Size size = const Size(20, 20),
  }) : super(key: key) {
    width = size.width;
    height = size.height;
  }

  @override
  State<StatefulWidget> createState() => DraggableVertexState();
}

class DraggableVertexState extends State<DraggableVertex> {
  Widget circle() {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
      ),
      // child: Center(
      //   child: Text(
      //     "Drag",
      //     style: Theme.of(context).textTheme.headline,
      //   ),
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.offset.dx - widget.width / 2,
      top: widget.offset.dy - widget.height / 2,
      child: Draggable(
        feedback: circle(),
        childWhenDragging: Container(),
        onDragEnd: (dragDetails) {
          widget.doneDragging = true;
          setState(
            () {
              widget.offset = Offset(
                dragDetails.offset.dx + widget.width / 2,
                dragDetails.offset.dy + widget.height / 2,
              );
            },
          );
        },
        child: circle(),
      ),
    );
  }
}
