import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';

import 'package:flame/game.dart';

import 'dart:math';
import '../components/dot.dart';

enum Type {
  triangle,
  square0,
  square1,
  square2,
  pentagon,
}

Vector2 midDot(Dot d1, Dot d2) {
  return Vector2(
    (d1.position.x + d2.position.x) / 2,
    (d1.position.y + d2.position.y) / 2,
  );
}

class Fractals extends FlameGame {
  // screen changes
  BuildContext context;
  late Size screenSize;

  // for non repetition
  Dot? lastVertex;
  Dot? lastLastVertex;

  // animation speed
  int dotSpeed = 1;
  ValueNotifier<int> numDots = ValueNotifier<int>(0);

  // fractal mode
  int mode;

  Dot pointA = Dot(Vector2(-10, -10), size: 0, color: Colors.black);
  Dot pointB = Dot(Vector2(-10, -10), size: 0, color: Colors.black);
  Dot pointC = Dot(Vector2(-10, -10), size: 0, color: Colors.black);
  Dot pointD = Dot(Vector2(-10, -10), size: 0, color: Colors.black);
  Dot pointE = Dot(Vector2(-10, -10), size: 0, color: Colors.black);
  Dot pointX = Dot(Vector2(-10, -10), size: 0, color: Colors.black);

  Fractals(this.context, this.mode) {
    screenSize = MediaQuery.of(context).size;
    pointX = Dot(
      size: 4,
      color: Colors.white,
      // Vector2(screenSize.width * 0.5, screenSize.height * 0.5),
      Vector2(
        screenSize.width * Random().nextDouble(),
        screenSize.height * Random().nextDouble(),
      ),
    );
  }

  // sierpenskis triangle equation
  Dot vertexChooser(int vertices) {
    // random int 0 <= x < 3
    final int randomInt = Random().nextInt(vertices);

    // choose vertex A
    if (randomInt == 0) {
      return pointA;
    }
    // choose vertex B
    else if (randomInt == 1) {
      return pointB;
    }
    // choose vertex C
    else if (randomInt == 2) {
      return pointC;
    }
    // choose vertex D
    else if (randomInt == 3) {
      return pointD;
    }
    // choose vertex E
    else {
      return pointE;
    }
  }

  void makeDots() {
    // N/A
  }

  @override
  Future<void>? onLoad() {
    TextComponent dotsText = TextComponent(
      text: "Dots: 0",
      position: Vector2(10, 50),
      priority: 1,
    );
    numDots.addListener(() => dotsText.text = "Dots: ${numDots.value}");

    add(pointA);
    add(pointB);
    add(pointC);
    add(pointD);
    add(pointE);
    add(pointX);
    add(dotsText);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    screenSize = MediaQuery.of(context).size;
    for (int i = 0; i < dotSpeed; i++) {
      makeDots();
      numDots.value++;
    }
    super.update(dt);
  }
}
