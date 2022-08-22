part of '/webgl.dart';

/// Represents an opaque buffer object storing data such as vertices or colors.
///
/// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGLBuffer.
@JS()
@sealed
@staticInterop
abstract class WebGLBuffer {}

/// Combinations of two compiled vertex and fragment shaders for Web GL.
///
/// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGLProgram.
@JS()
@sealed
@staticInterop
abstract class WebGLProgram {}

/// Part of the WebGL API and can either be a vertex or a fragment shader.
///
/// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGLShader.
@JS()
@sealed
@staticInterop
abstract class WebGLShader {}

/// Represents an opaque texture object providing state for texturing.
///
/// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGLTexture.
@JS()
@sealed
@staticInterop
abstract class WebGLTexture {}

/// Represents the location of a uniform variable in a shader program.
///
/// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGLUniformLocation.
@JS()
@sealed
@staticInterop
abstract class WebGLUniformLocation {}
