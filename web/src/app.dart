/// Meant to be roughly the Dart equivalent of JS13K-2D's "app.js".
///
/// See: https://github.com/kutuluk/js13k-2d/blob/master/example/src/app.js.
library app;

import 'dart:math' as math;

import 'package:js/js.dart';
import 'package:twod/dom.dart';
import 'package:twod/twod.dart';

import 'atlas.dart';
import 'debug.dart';
import 'logo.dart';

void runApp(HTMLCanvasElement canvas) {
  final random = math.Random();
  final scene = Scene.fromCanvas(canvas)
    ..setBackground(1, 1, 1, 0)
    ..cameraOrigin = Point(400, 300)
    ..cameraTarget = Point(0.5);

  final atlas = scene.createTexture(
    createAtlasImage(),
    alphaTest: 0.5,
  )..anchor = Point(0.5);

  final bFrame = atlas.frame(Point(0), Point(32));
  final qFrame = atlas.frame(Point(32, 0), Point(32));
  final fFrame = atlas.frame(Point(64, 0), Point(32));
  final frames = [atlas, bFrame, qFrame, fFrame];

  var length = 0;
  var zIndex = 0;

  void addSprites(int amount) {
    if (length % 250 == 0) {
      zIndex++;
    }

    final layer = scene.getLayer(zIndex);

    for (var i = 0; i < amount; i++) {
      final sprite = Sprite(frames[i % 4]);

      var x = 0;
      var y = 0;
      while (!logoMask(x, y)) {
        x = random.nextInt(800);
        y = random.nextInt(600);
      }

      sprite
        ..position = Point(x as double, y as double)
        ..tint = random.nextInt(0xfffffff)
        ..rotation = random.nextDouble() * math.pi * 2;

      layer.add(sprite);
    }

    length += amount;
  }

  void gameLoop() {
    if (length < 25) {
      addSprites(25);
    }

    scene.render();

    /*
    scene
      ..cameraAngle += 0.005
      ..render();
    */

    if (assertionsEnabled) {
      scene.assertNoWebGLErrors();
    }

    if (canvas.isConnected) {
      window.requestAnimationFrame(allowInterop((_) => gameLoop()));
    } else {
      debugLog('<canvas> unmounted: ending game loop', canvas);
    }
  }

  gameLoop();
}
