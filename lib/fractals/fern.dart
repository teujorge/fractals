import 'dart:math';

import 'package:flame/extensions.dart';

import 'fractals.dart';

class FernFractalPainter extends FractalPainter {
  double x = 0;
  double y = 0;

  FernFractalPainter({super.mode}) {
    points[0] = const Offset(0, 0);
  }

  @override
  void makeDots() {
    double r = Random().nextDouble();

    if (r < 0.01) {
      x = 0.00 * x + 0.00 * y;
      y = 0.00 * x + 0.16 * y + 0.00;
    } else if (r < 0.86) {
      x = 0.85 * x + 0.04 * y;
      y = -0.04 * x + 0.85 * y + 1.60;
    } else if (r < 0.93) {
      x = 0.20 * x - 0.26 * y;
      y = 0.23 * x + 0.22 * y + 1.60;
    } else {
      x = -0.15 * x + 0.28 * y;
      y = 0.26 * x + 0.24 * y + 0.44;
    }

    points.add(
      Offset(
        0.5 + 65 * x / 500,
        1 - (0.1 + 37 * y / 500),
      ),
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    // init vertex
    if (vertices.isEmpty) {
      vertices.add(const Offset(0, 0));
    }
    super.paint(canvas, size);
  }
}
