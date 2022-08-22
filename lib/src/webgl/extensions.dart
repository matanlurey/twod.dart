part of '/webgl.dart';

/// Part of the WebGL API that allows droping the same object(s) multiple times.
///
/// See: https://developer.mozilla.org/en-US/docs/Web/API/ANGLE_instanced_arrays.
@JS()
@sealed
@staticInterop
abstract class WebGLAngleInstancedArrays {}

/// Methods provided to [WebGLAngleInstancedArrays] using [staticInterop].
///
/// See https://pub.dev/packages/js#interop-with-native-types-using-staticinterop.
extension WebGLAngleInstancedArrays$ on WebGLAngleInstancedArrays {
  /// Renders primitives from array data like the `gl.drawElements()` method.
  ///
  /// See: https://developer.mozilla.org/en-US/docs/Web/API/ANGLE_instanced_arrays/drawElementsInstancedANGLE
  external void drawElementsInstancedANGLE(
    int mode,
    int count,
    int type,
    int offset,
    int primcount,
  );

  /// Modifies the rate at which generic vertex attributes advances.
  ///
  /// See: https://developer.mozilla.org/en-US/docs/Web/API/ANGLE_instanced_arrays/vertexAttribDivisorANGLE
  external void vertexAttribDivisorANGLE(int index, int divisor);
}
