// ignore_for_file: public_member_api_docs, non_constant_identifier_names

part of '/webgl.dart';

/// Collection of constant values that are exported by `WebGL_API.Types`.
///
/// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGL_API/Constants#blending_modes
@JS()
@sealed
@staticInterop
abstract class HasWebGLBlendingModes {}

/// Collection of constant values that are exported by `WebGL_API.Types`.
///
/// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGL_API/Constants#enabling_and_disabling
@JS()
@sealed
@staticInterop
abstract class HasWebGLCapabilities {}

/// Collection of constant values that can be read from a WebGL context.
@JS()
@sealed
@staticInterop
abstract class HasWebGLConstants
    implements /*
    */
        HasWebGLBlendingModes,
        HasWebGLErrorCodes,
        HasWebGLCapabilities {}

/// Collection of constant error codes that can be read from a WebGL context.
@JS()
@sealed
@staticInterop
abstract class HasWebGLErrorCodes {}

/// Methods provided to [HasWebGLErrorCodes] using [staticInterop].
///
/// See https://pub.dev/packages/js#interop-with-native-types-using-staticinterop.
extension HasWebGLErrorCodes$ on HasWebGLErrorCodes {
  external int get NO_ERROR;
  external int get INVALID_ENUM;
  external int get INVALID_VALUE;
  external int get INVALID_OPERATION;
  external int get INVALID_FRAMEBUFFER_OPERATION;
  external int get OUT_OF_MEMORY;
  external int get CONTEXT_LOST_WEBGL;
}

/// Methods provided to [HasWebGLBlendingModes] using [staticInterop].
///
/// See https://pub.dev/packages/js#interop-with-native-types-using-staticinterop.
extension HasWebGLBlendingModes$ on HasWebGLBlendingModes {
  /// Multiplies all colors by a constant alpha value.
  external int get CONSTANT_ALPHA;

  /// Multiplies all colors by a constant color.
  external int get CONSTANT_COLOR;

  /// Multiplies all colors by the destination alpha value.
  external int get DST_ALPHA;

  /// Multiplies all colors by the destination color.
  external int get DST_COLOR;

  /// Multiplies all colors by 1.
  external int get ONE;

  /// Multiplies all colors by 1 minus a constant alpha value.
  external int get ONE_MINUS_CONSTANT_ALPHA;

  /// Multiplies all colors by 1 minus a constant color.
  external int get ONE_MINUS_CONSTANT_COLOR;

  /// Multiplies all colors by 1 minus the destination alpha value.
  external int get ONE_MINUS_DST_ALPHA;

  /// Multiplies all colors by 1 minus each destination color.
  external int get ONE_MINUS_DST_COLOR;

  /// Multiplies all colors by 1 minus the source alpha value.
  external int get ONE_MINUS_SRC_ALPHA;

  /// Multiplies all colors by 1 minus each source color.
  external int get ONE_MINUS_SRC_COLOR;

  /// Multiplies all colors by the source alpha value.
  external int get SRC_ALPHA;

  /// Multiplies the RGB colors by the smaller of either alpha values.
  ///
  /// I.e. the _source_ alpha value or the value of 1 minus the _destination_
  /// alpha value.
  ///
  /// The alpha value is multiplied by 1.
  external int get SRC_ALPHA_SATURATE;

  /// Multiplies all colors by the source colors.
  external int get SRC_COLOR;

  /// Multiplies all colors by 0.
  external int get ZERO;
}

/// Methods provided to [HasWebGLCapabilities] using [staticInterop].
///
/// See https://pub.dev/packages/js#interop-with-native-types-using-staticinterop.
extension HasWebGLCapabilities$ on HasWebGLCapabilities {
  /// May enable/disable blending.
  ///
  /// Can be used with `getParameter` to find the current blending method.
  external int get BLEND;

  /// May enable/disable depth test.
  ///
  /// Can be used with `getParameter` to query the depth test.
  external int get DEPTH_TEST;

  /// May enable/disable dithering.
  ///
  /// Can be used with `getParameter` to find the current dithering method.
  external int get DITHER;

  /// May enable/disable polygon offset.
  ///
  /// Useful for rendering hidden-line images, decals, or solids with
  /// highlighted edges.
  ///
  /// Can be used with `getParameter` to query the scissor test.
  external int get POLYGON_OFFSET_FILL;

  /// May enable/disable alpha to coverage.
  ///
  /// Used in multi-sampling alpha channels.
  external int get SAMPLE_ALPHA_TO_COVERAGE;

  /// May enable/disable sample coverage.
  ///
  /// Used in multi-sampling.
  external int get SAMPLE_COVERAGE;

  /// May enable/disable scissor test.
  ///
  /// Can be used with `getParameter` to query the scissor test.
  external int get SCISSOR_TEST;

  /// May enable/disable stencil test.
  ///
  /// Can be used with `getParameter` to query the stencil test.
  external int get STENCIL_TEST;
}

/// Methods provided to [HasWebGLConstants] using [staticInterop].
///
/// See https://pub.dev/packages/js#interop-with-native-types-using-staticinterop.
extension HasWebGLConstants$ on HasWebGLConstants {
  external int get ACTIVE_ATTRIBUTES;
  external int get ACTIVE_UNIFORMS;
  external int get ALWAYS;
  external int get ARRAY_BUFFER;
  external int get ATTACHED_SHADERS;
  external int get COLOR_BUFFER_BIT;
  external int get COMPILE_STATUS;
  external int get DELETE_STATUS;
  external int get DEPTH_BUFFER_BIT;
  external int get DYNAMIC_DRAW;
  external int get ELEMENT_ARRAY_BUFFER;
  external int get EQUAL;
  external int get FLOAT;
  external int get FRAGMENT_SHADER;
  external int get GEQUAL;
  external int get GREATER;
  external int get LEQUAL;
  external int get LESS;
  external int get LINK_STATUS;
  external int get NEAREST;
  external int get NEVER;
  external int get NOTEQUAL;
  external int get RGBA;
  external int get SHADER_TYPE;
  external int get STATIC_DRAW;
  external int get STENCIL_BUFFER_BIT;
  external int get STREAM_DRAW;
  external int get TEXTURE_2D;
  external int get TEXTURE_CUBE_MAP;
  external int get TEXTURE_MAG_FILTER;
  external int get TEXTURE_MIN_FILTER;
  external int get TRIANGLES;
  external int get UNSIGNED_BYTE;
  external int get VALIDATE_STATUS;
  external int get VERTEX_SHADER;
}
