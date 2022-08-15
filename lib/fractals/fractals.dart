import 'package:flutter/material.dart';

import 'dart:math';

enum Type {
  triangle,
  fern,
  julia,
  square0,
  square1,
  square2,
  pentagon,
}

Offset midPoint(Offset p1, Offset p2) {
  return Offset(
    (p1.dx + p2.dx) / 2,
    (p1.dy + p2.dy) / 2,
  );
}

class FractalPainter extends CustomPainter {
  // screen size
  Size screenSize = const Size(0, 0);

  // for non repetition
  Offset? newVertex;
  Offset? lastVertex;
  Offset? lastLastVertex;

  // fractal mode
  int mode;

  List<Offset> vertices = [];
  List<Offset> points = [];

  Paint vertexPaint = Paint()..color = Colors.red;
  Paint pointPaint = Paint()..color = Colors.amber;

  FractalPainter(this.mode) {
    // create initial random point
    points.add(
      Offset(
        600 * Random().nextDouble(),
        400 * Random().nextDouble(),
      ),
    );
  }

  // sierpenskis triangle equation
  Offset vertexChooser(int numVertices) {
    // random int 0 <= x < 3
    final int randomInt = Random().nextInt(numVertices);

    // choose vertex A
    if (randomInt == 0) {
      return vertices[0];
    }
    // choose vertex B
    else if (randomInt == 1) {
      return vertices[1];
    }
    // choose vertex C
    else if (randomInt == 2) {
      return vertices[2];
    }
    // choose vertex D
    else if (randomInt == 3) {
      return vertices[3];
    }
    // choose vertex E
    else {
      return vertices[4];
    }
  }

  void makeDots() {
    // mid point
    Offset mid = midPoint(
      Offset(
        points[points.length - 1].dx * screenSize.width,
        points[points.length - 1].dy * screenSize.height,
      ),
      newVertex!,
    );

    // add location as percentage
    points.add(
      Offset(
        mid.dx / screenSize.width,
        mid.dy / screenSize.height,
      ),
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    // draw vertices
    for (Offset point in vertices) {
      canvas.drawCircle(
        point,
        5,
        vertexPaint,
      );
    }

    double smallestDim = (screenSize.width < screenSize.height)
        ? screenSize.width
        : screenSize.height;
    smallestDim /= 800;

    // draw all points
    for (Offset point in points) {
      canvas.drawCircle(
        // from percentage draw on location
        Offset(
          point.dx * screenSize.width,
          point.dy * screenSize.height,
        ),
        smallestDim,
        pointPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
