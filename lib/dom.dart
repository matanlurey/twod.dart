// ignore_for_file: public_member_api_docs

/// A minimal DOM library that serves as a JS interface instead of `dart:html`.
///
/// Using `dart:html` is prohibitivly expensive in terms of code-size because it
/// provides semantics (such as dynamic dispatch) that we won't utilize but
/// cannot disable.
///
/// Given the only use of this library is to find a `<canvas>` element, we
/// choose to have the most minimal/lightweight interface using preferred JS
/// interop techniques (https://pub.dev/packages/js#interop-with-native-types-using-staticinterop).
///
/// ## Usage
///
/// ```
/// import 'dom.dart';
///
/// void main() {
///   window.document.getElementById('some-canvas-id');
/// }
/// ```
@experimental
library dom;

import 'dart:typed_data';

import 'package:js/js.dart';
import 'package:meta/meta.dart';

@JS()
@staticInterop
external JSWindow get window;

@JS()
@sealed
@staticInterop
abstract class JSWindow {}

extension JSWindow$ on JSWindow {
  external JSConsole get console;
  external JSDocument get document;
  external void requestAnimationFrame(void Function(num timestamp) onNext);
}

@JS('console')
@sealed
@staticInterop
abstract class JSConsole {}

extension JSConsole$ on JSConsole {
  external void log(Object? a);
}

@JS()
@sealed
@staticInterop
abstract class JSDocument {}

extension JSDocument$ on JSDocument {
  external JSElement? get body;
  external JSElement createElement(String tagName);
  external JSElement? getElementById(String name);
}

@JS()
@sealed
@staticInterop
abstract class JSElement {}

extension JSElement$ on JSElement {
  external void appendChild(JSElement other);
  external bool get isConnected;
  external JSElement? get firstChild;
  external JSDOMRect getBoundingClientRect();
  external void removeChild(JSElement other);
  external double get height;
  external set height(double height);
  external double get width;
  external set width(double width);
}

@JS()
@sealed
@staticInterop
abstract class JSDOMRect {}

extension JSDomRect$ on JSDOMRect {
  external double get width;
  external double get height;
}

/// Provides properties and methods or manipulating `<canvas>` elements.
///
/// See: https://developer.mozilla.org/en-US/docs/Web/API/HTMLCanvasElement.
@JS()
@sealed
@staticInterop
abstract class HTMLCanvasElement implements JSElement {}

/// Methods provided to [HTMLCanvasElement] using [staticInterop].
///
/// See https://pub.dev/packages/js#interop-with-native-types-using-staticinterop.
extension HTMLCanvasElement$ on HTMLCanvasElement {
  /// Returns a drawing context on the canvas, or `null` if not supported.
  ///
  /// See: https://developer.mozilla.org/en-US/docs/Web/API/HTMLCanvasElement/getContext
  external Object? getContext(String contextType, [Object? contextAttributes]);
}

/// Provides 2D rendering context for the drawing surface of a `<canvas>`.
///
/// See: https://developer.mozilla.org/en-US/docs/Web/API/CanvasRenderingContext2D.
@JS()
@sealed
@staticInterop
abstract class CanvasRenderingContext2D {}

/// Methods provided to [CanvasRenderingContext2D] using [staticInterop].
///
/// See https://pub.dev/packages/js#interop-with-native-types-using-staticinterop.
extension CanvasRenderingContext2D$ on CanvasRenderingContext2D {
  external set lineWidth(double lineWidth);
  external set fillStyle(String hexColor);
  external set strokeStyle(String hexColor);
  external void beginPath();
  external void closePath();
  external void moveTo(num x, num y);
  external void lineTo(num x, num y);
  external void fill();
  external void stroke();
  external ImageData getImageData(num sx, num sy, num sw, num sh);
}

/// Represents the underlying pixel data of an area of a `<canvas>` element.
///
/// See: https://developer.mozilla.org/en-US/docs/Web/API/ImageData
@JS()
@sealed
@staticInterop
abstract class ImageData {}

/// Methods provided to [ImageData] using [staticInterop].
///
/// See https://pub.dev/packages/js#interop-with-native-types-using-staticinterop.
extension ImageData$ on ImageData {
  external Uint8ClampedList get data;
  external int get height;
  external int get width;
}
