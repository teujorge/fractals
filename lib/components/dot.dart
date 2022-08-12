import 'package:flame/extensions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../fractals/fractals.dart';

class Dot extends Component {
  final int size;
  final Color color;
  late Vector2 position;

  Dot(
    this.position, {
    this.size = 20,
    this.color = const Color.fromARGB(255, 10, 255, 10),
  });

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(
      Offset(position.x, position.y),
      size / 2,
      Paint()..color = color,
    );
  }
}

class SmallDot extends Dot {
  final Dot d1;
  final Dot d2;

  SmallDot(this.d1, this.d2)
      : super(
          midDot(d1, d2),
          size: 1,
          color: const Color.fromARGB(255, 255, 247, 10),
        );

  @override
  void update(double dt) {
    position = midDot(d1, d2);
    super.update(dt);
  }
}
