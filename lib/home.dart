import 'package:flutter/material.dart';
import 'package:fractals/fractals/fractals.dart';

import 'play.dart';

class GameSelection extends StatelessWidget {
  const GameSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      builder: (context) => const PlayView(Type.triangle),
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
                      builder: (context) => const PlayView(Type.square0),
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
                      builder: (context) => const PlayView(Type.square1),
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
                      builder: (context) => const PlayView(Type.square2),
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
                      builder: (context) => const PlayView(Type.pentagon),
                    ),
                  );
                },
                child: const Text("pentagon"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
