import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'fractals.dart';

class JuliaFractalPainter extends FractalPainter {
  // setting zoom
  int zoom = 1;

  // pixel location
  double x = 0;
  double y = 0;

  // variable for Julia eqs
  double cX = -0.7;
  double cY = 0.27015;
  double moveX = 0.0;
  double moveY = 0.0;
  int maxIter = 255;

  // color list
  List<Color> pointsColors = [Colors.amber];

  JuliaFractalPainter({super.mode}) {
    points[0] = const Offset(0, 0);
  }

  Uint8List int32bytes(int value) =>
      Uint8List(4)..buffer.asInt32List()[0] = value;

  @override
  void makeDots() {
    double w = 400;
    double h = 400;

    if (y >= h) {
      x += 1.8;
      y = 0;
    } else {
      y += 1.8;
    }

    double zx = 1.5 * (x - w / 2) / (0.5 * zoom * w) + moveX;
    double zy = 1.0 * (y - h / 2) / (0.5 * zoom * h) + moveY;
    int i = maxIter;

    while (zx * zx + zy * zy < 4 && i > 1) {
      double tmp = zx * zx - zy * zy + cX;
      zy = 2.0 * zx * zy + cY;
      zx = tmp;
      i--;
    }

    // convert byte to RGB
    Uint8List pixColorBytes = int32bytes((i << 21) + (i << 10) + i * 8);

    pointsColors.add(
      Color.fromARGB(
        pixColorBytes[0],
        pixColorBytes[1],
        pixColorBytes[2],
        pixColorBytes[3],
      ),
    );

    if (y / 400 > screenSize.height) {
      return;
    }
    points.add(
      Offset(
        x / 400,
        y / 400,
      ),
    );

    print("$x $y $pixColorBytes");
  }

  @override
  void paint(Canvas canvas, Size size) {
    // init vertex
    if (vertices.isEmpty) {
      vertices.add(const Offset(0, 0));
    }

    double smallestDim = (screenSize.width < screenSize.height)
        ? screenSize.width
        : screenSize.height;

    smallestDim /= 300;

    // draw all points
    for (int i = 0; i < points.length; i++) {
      canvas.drawCircle(
        // from percentage draw on location
        Offset(
          points[i].dx * screenSize.width,
          points[i].dy * screenSize.height,
        ),
        smallestDim,
        pointPaint..color = pointsColors[i],
      );
    }
  }
}
