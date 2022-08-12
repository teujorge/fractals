import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:fractals/fractals/fractals.dart';
import 'package:fractals/fractals/triangles.dart';

import 'package:flame/extensions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'dart:math';

import 'play.dart';

class GameSelection extends StatelessWidget {
  const GameSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => GamePlay(Type.triangle),
                      ),
                    );
                  },
                  child: const Text("triangle"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => GamePlay(Type.square0),
                      ),
                    );
                  },
                  child: const Text("square0"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => GamePlay(Type.square1),
                      ),
                    );
                  },
                  child: const Text("square1"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => GamePlay(Type.square2),
                      ),
                    );
                  },
                  child: const Text("square2"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => GamePlay(Type.pentagon),
                      ),
                    );
                  },
                  child: const Text("pentagon"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
