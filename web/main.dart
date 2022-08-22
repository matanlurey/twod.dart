library main;

import 'package:twod/dom.dart';

import 'src/app.dart';
import 'src/debug.dart';

void main() {
  final view = window.document.getElementById('view');

  // In dev mode (i.e. DartDevCompiler), hot reload may have been invoked.
  if (assertionsEnabled && view!.firstChild != null) {
    debugLog('During reload removed <canvas>', view.firstChild);
    view.removeChild(view.firstChild!);
  }

  // Create a <canvas> element, initialize it, and prepare to initialize Web GL.
  final canvas = window.document.createElement('canvas') as HTMLCanvasElement;
  final viewport = view!.getBoundingClientRect();
  canvas
    ..width = viewport.width
    ..height = viewport.height;
  view.appendChild(canvas);

  // Start the app/demo. The "juicy" parts of the code are in app.dart.
  runApp(canvas);
}
