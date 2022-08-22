import 'dart:math' as math;
import 'dart:typed_data';

import 'package:twod/dom.dart';

/// Returns whether [x] and [y] should be masked off to represent a logo.
///
/// See: https://github.com/kutuluk/js13k-2d/blob/d4a7d132b7239071fbd45382ae2de2793ae7e39c/example/src/app.js.
bool logoMask(int x, int y) => _maskData[(y * 800 + x) * 4] > 0;

final _maskData = _createLogoMask();
Uint8ClampedList _createLogoMask() {
  final canvas = (window.document.createElement('canvas') as HTMLCanvasElement)
    ..width = 800
    ..height = 600;

  final gl = (canvas.getContext('2d')! as CanvasRenderingContext2D)
    ..fillStyle = '#ffffff'
    ..beginPath()
    ..moveTo(400, 300);

  for (var angle = 0.0; angle < math.pi * 2; angle += (math.pi * 2) / 5) {
    gl.lineTo(400 - math.sin(angle) * 250, 300 - math.cos(angle) * 250);
  }

  gl
    ..closePath()
    ..fill();

  return gl.getImageData(0, 0, 800, 600).data;
}
