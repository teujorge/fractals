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
  na,
}

class FractalPainter extends CustomPainter {
  // screen size
  Size screenSize = const Size(0, 0);

  // for non repetition
  int numVertices = 0;
  Offset? newVertex;
  Offset? lastVertex;
  Offset? lastLastVertex;

  // fractal mode
  int mode;

  // change midpoint fraction
  int numerator = 1;
  int denominator = 2;

  List<Offset> verticesP = [];
  List<Offset> vertices = [];
  List<Offset> points = [];

  Paint vertexPaint = Paint()..color = Colors.purple;
  Paint pointPaint = Paint()..color = Colors.lightBlueAccent;

  FractalPainter({this.mode = 0}) {
    // create initial random point
    points.add(
      Offset(
        600 * Random().nextDouble(),
        400 * Random().nextDouble(),
      ),
    );
  }

  Offset midPoint(Offset p1, Offset p2) {
    return Offset(
      p1.dx + (numerator * (p2.dx - p1.dx) / denominator),
      p1.dy + (numerator * (p2.dy - p1.dy) / denominator),
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

  void paintVerticesTriangle() {
    if (vertices.isEmpty) {
      verticesP = [
        const Offset(0.1, 0.9),
        const Offset(0.5, 0.1),
        const Offset(0.9, 0.9),
      ];
    }
    vertices = [
      Offset(
        screenSize.width * verticesP[0].dx,
        screenSize.height * verticesP[0].dy,
      ),
      Offset(
        screenSize.width * verticesP[1].dx,
        screenSize.height * verticesP[1].dy,
      ),
      Offset(
        screenSize.width * verticesP[2].dx,
        screenSize.height * verticesP[2].dy,
      ),
    ];
  }

  void paintVerticesSquare() {
    if (vertices.isEmpty) {
      verticesP = [
        const Offset(0.1, 0.1),
        const Offset(0.9, 0.1),
        const Offset(0.9, 0.9),
        const Offset(0.1, 0.9),
      ];
    }
    vertices = [
      Offset(
        screenSize.width * verticesP[0].dx,
        screenSize.height * verticesP[0].dy,
      ),
      Offset(
        screenSize.width * verticesP[1].dx,
        screenSize.height * verticesP[1].dy,
      ),
      Offset(
        screenSize.width * verticesP[2].dx,
        screenSize.height * verticesP[2].dy,
      ),
      Offset(
        screenSize.width * verticesP[3].dx,
        screenSize.height * verticesP[3].dy,
      ),
    ];
  }

  void paintVerticesPentagon() {
    if (vertices.isEmpty) {
      verticesP = [
        const Offset(0.25, 0.1),
        const Offset(0.75, 0.1),
        const Offset(0.9, 0.5),
        const Offset(0.5, 0.9),
        const Offset(0.1, 0.5),
      ];
    }
    vertices = [
      Offset(
        screenSize.width * verticesP[0].dx,
        screenSize.height * verticesP[0].dy,
      ),
      Offset(
        screenSize.width * verticesP[1].dx,
        screenSize.height * verticesP[1].dy,
      ),
      Offset(
        screenSize.width * verticesP[2].dx,
        screenSize.height * verticesP[2].dy,
      ),
      Offset(
        screenSize.width * verticesP[3].dx,
        screenSize.height * verticesP[3].dy,
      ),
      Offset(
        screenSize.width * verticesP[4].dx,
        screenSize.height * verticesP[4].dy,
      ),
    ];
  }

  @override
  void paint(Canvas canvas, Size size) {
    // draw vertices and faces
    for (int i = 0; i < vertices.length - 1; i++) {
      canvas.drawCircle(vertices[i], 5, vertexPaint);
      canvas.drawLine(vertices[i], vertices[i + 1], vertexPaint);
    }
    canvas.drawCircle(vertices[vertices.length - 1], 5, vertexPaint);
    canvas.drawLine(vertices[0], vertices[vertices.length - 1], vertexPaint);

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
