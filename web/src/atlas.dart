import 'dart:math' as math;

import 'package:twod/dom.dart';

/// Creates the atlas image used for this demo.
///
/// See: https://github.com/kutuluk/js13k-2d/blob/d4a7d132b7239071fbd45382ae2de2793ae7e39c/example/src/app.js.
JSElement createAtlasImage() {
  final canvas = window.document.createElement('canvas') as HTMLCanvasElement;
  const size = 32;
  const half = size / 2;
  canvas
    ..width = 128
    ..height = 32;

  final gl = canvas.getContext('2d')! as CanvasRenderingContext2D;
  var offset = 0;

  gl
    ..lineWidth = size / 16
    ..fillStyle = '#cccccc'
    ..strokeStyle = '#000000'
    ..beginPath()
    ..moveTo(offset + half, half);
  for (var angle = 0.0; angle < math.pi * 2; angle += (math.pi * 2) / 5) {
    gl.lineTo(
      offset + half - math.sin(angle) * half * 0.9,
      half - math.cos(angle) * half * 0.9,
    );
  }

  gl
    ..closePath()
    ..fill()
    ..stroke();

  offset += size;

  gl
    ..beginPath()
    ..moveTo(offset + 3, 3)
    ..lineTo(offset + size - 3, 3)
    ..lineTo(offset + size - 3, size - 3)
    ..lineTo(offset + 3, size - 3)
    ..closePath()
    ..fill()
    ..stroke();

  offset += size;

  gl
    ..beginPath()
    ..moveTo(offset + 3, 3)
    ..lineTo(offset + 29, 3)
    ..lineTo(offset + 29, 8)
    ..lineTo(offset + 8, 8)
    ..lineTo(offset + 8, 14)
    ..lineTo(offset + 20, 14)
    ..lineTo(offset + 20, 18)
    ..lineTo(offset + 8, 18)
    ..lineTo(offset + 8, 29)
    ..lineTo(offset + 3, 29)
    ..closePath()
    ..fill()
    ..stroke();

  return canvas;
}
