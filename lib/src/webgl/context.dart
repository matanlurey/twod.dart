// ignore_for_file: avoid_classes_with_only_static_members, avoid_positional_boolean_parameters, public_member_api_docs

part of '/webgl.dart';

/// OpenGL ES 2.0 graphics rendering context for drawing to a `<canvas>`.
///
/// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext.
@JS()
@sealed
@staticInterop
abstract class WebGLRenderingContext implements HasWebGLConstants {}

@JS()
@anonymous
@sealed
@staticInterop
abstract class _WebGLGetContextAttributes {
  external factory _WebGLGetContextAttributes({
    bool? alpha,
    bool? antialias,
  });
}

/// Methods provided to [WebGLRenderingContext] using [staticInterop].
///
/// See https://pub.dev/packages/js#interop-with-native-types-using-staticinterop.
extension WebGLRenderingContext$ on WebGLRenderingContext {
  /// Creates a [WebGLRenderingContext] via [HTMLCanvasElement$.getContext].
  static WebGLRenderingContext fromCanvas(
    HTMLCanvasElement canvas, {
    bool? alpha,
    bool? antialias,
  }) {
    final context = canvas.getContext(
      'webgl',
      _WebGLGetContextAttributes(alpha: alpha, antialias: antialias),
    );
    if (context == null) {
      throw UnsupportedError('WebGL not supported');
    }
    return context as WebGLRenderingContext;
  }

  /// Attaches either a fragment or vertex [shader] to a [program].
  ///
  /// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext/attachShader
  external void attachShader(WebGLProgram program, WebGLShader shader);

  /// Binds a given [buffer] to a [target].
  ///
  /// Possible values of [target] include:
  /// - [ARRAY_BUFFER]
  /// - [ELEMENT_ARRAY_BUFFER]
  ///
  /// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext/bindBuffer
  external void bindBuffer(int target, WebGLBuffer buffer);

  /// Binds a given [texture] to a [target].
  ///
  /// Possible values of [target] include:
  /// - [TEXTURE_2D]
  /// - [TEXTURE_CUBE_MAP]
  ///
  /// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext/bindTexture
  external void bindTexture(int target, WebGLTexture texture);

  /// Defines which function is used for blending pixel arithmetic.
  ///
  /// [sfactor]: Multiplier for the source blending factors.
  /// Default is [ONE].
  /// [dfactor]: Multiplier for the destination blending factors.
  /// Default is [ZERO].
  ///
  /// For possible values for either parameter, see [HasWebGLBlendingModes$].
  ///
  /// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext/blendFunc
  external void blendFunc(int sfactor, int dfactor);

  /// Defines which function compares incoming pixel depth to the current value.
  ///
  /// Possible values of [func] include:
  /// - [NEVER]
  /// - [LESS]
  /// - [EQUAL]
  /// - [LEQUAL]
  /// - [GREATER]
  /// - [NOTEQUAL]
  /// - [GEQUAL]
  /// - [ALWAYS]
  ///
  /// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext/depthFunc
  external void depthFunc(int func);

  /// Initializes and creates the buffer object's data store.
  ///
  /// Possible values of [target] include:
  /// - [ARRAY_BUFFER]
  /// - [ELEMENT_ARRAY_BUFFER]
  ///
  /// [srcData] will be copied into the data store.
  ///
  /// Possible values of [usage] include:
  /// - [STATIC_DRAW]
  /// - [DYNAMIC_DRAW]
  /// - [STREAM_DRAW]
  ///
  /// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext/bufferData
  external void bufferData(int target, TypedData srcData, int usage);

  /// Updates a subset of a buffer object's data store.
  ///
  /// Possible values of [target] include:
  /// - [ARRAY_BUFFER]
  /// - [ELEMENT_ARRAY_BUFFER]
  ///
  /// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext/bufferSubData
  external void bufferSubData(int target, int offset, TypedData srcData);

  /// Clears buffers to preset values.
  ///
  /// Possible values of [mask] include:
  /// - [COLOR_BUFFER_BIT]
  /// - [DEPTH_BUFFER_BIT]
  /// - [STENCIL_BUFFER_BIT]
  ///
  /// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext/clear
  external void clear(int mask);

  /// Specifies the color values using when clearing color buffers.
  ///
  /// This method specifies what color values to use when calling [clear]. The
  /// values are clamped between 0 and 1, and the default value for each is 0.
  ///
  /// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext/clearColor
  external void clearColor(
    double red,
    double green,
    double blue,
    double alpha,
  );

  /// Compiles a [shader] into binary data so that it can be used by a program.
  ///
  /// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext/compileShader
  external void compileShader(WebGLShader shader);

  /// Creates and initializes a buffer storing data such as vertices or colors.
  ///
  /// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext/createBuffer
  external WebGLBuffer createBuffer();

  /// Creates and initializes a [WebGLProgram].
  ///
  /// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext/createProgram
  external WebGLProgram createProgram();

  /// Creates a shader configurable using [shaderSource] and [compileShader].
  ///
  /// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext/createShader
  external WebGLShader createShader(int type);

  /// Creates and initializes a [WebGLTexture] object.
  ///
  /// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext/createTexture
  external WebGLTexture createTexture();

  /// Deletes a given [program].
  ///
  /// This method has no effect if the program has already been deleted.
  ///
  /// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext/deleteProgram
  external void deleteProgram(WebGLProgram program);

  /// Marks a given [shader] object for deletion.
  ///
  /// The object will be deleted when the shader is no longer in use.
  ///
  /// This method has no effect if the shader has already been deleted, and the
  /// [WebGLShader ]is automatically marked for deletion when it is destroyed by
  /// the garbage collector.
  ///
  /// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext/deleteShader
  external void deleteShader(WebGLShader shader);

  /// Disables specific WebGL capabilities for this context.
  ///
  /// Possible values for [capability] include:
  /// - [BLEND]
  /// - [DEPTH_TEST]
  /// - [DITHER]
  /// - [POLYGON_OFFSET_FILL]
  /// - [SAMPLE_ALPHA_TO_COVERAGE]
  /// - [SAMPLE_COVERAGE]
  ///
  /// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext/disable
  external void disable(int capability);

  /// Enables specific WebGL capabilities for this context.
  ///
  /// Possible values for [capability] include:
  /// - [BLEND]
  /// - [DEPTH_TEST]
  /// - [DITHER]
  /// - [POLYGON_OFFSET_FILL]
  /// - [SAMPLE_ALPHA_TO_COVERAGE]
  /// - [SAMPLE_COVERAGE]
  /// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext/enable
  external void enable(int capability);

  /// Turns on the generic vertex attribute array at the specified [index].
  ///
  /// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext/enableVertexAttribArray
  external void enableVertexAttribArray(int index);

  /// Generates a set of mipmaps for a [WebGLTexture] object.
  ///
  /// Mipmaps are used to create distance with objects. A higher-resolution
  /// mipmap is used for objects that are closer, and a lower-resolution mipmap
  /// is used for objects that are farther away. It starts with the resolution
  /// of the texture image and halves the resolution until a 1x1 dimension
  /// texture image is created.
  ///
  /// Possible values of [target] include:
  /// - [TEXTURE_2D]
  /// - [TEXTURE_CUBE_MAP]
  ///
  /// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext/generateMipmap
  external void generateMipmap(int target);

  /// Returns the location of the attribute value in a given [program].
  ///
  /// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext/getAttribLocation
  external int getAttribLocation(WebGLProgram program, String name);

  /// Returns error information.
  ///
  /// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext/getError
  external int getError();

  /// Enables a WebGL extension with the provided [name].
  ///
  /// Returns `null` if the name doesn't match one of the strings in
  /// [getSupportedExtensions].
  ///
  /// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext/getExtension
  external Object? getExtension(String name);

  /// Returns a list of all the supported WebGL extensions.
  external List<Object?> getSupportedExtensions();

  /// Returns information about the given [program].
  ///
  /// Possible values of [pname] include:
  /// - [DELETE_STATUS]; returns if flagged for deletion.
  /// - [LINK_STATUS]; returns if last link was successful.
  /// - [VALIDATE_STATUS]; returns if last validation succeeded.
  /// - [ATTACHED_SHADERS]; returns number of attached shaders.
  /// - [ACTIVE_ATTRIBUTES]; returns number of active attribute variables.
  /// - [ACTIVE_UNIFORMS]; returns number of active uniform variables.
  ///
  /// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext/getProgramParameter
  external Object getProgramParameter(WebGLProgram program, int pname);

  /// Returns the information log for the specified [shader].
  ///
  /// It contains warnings, debugging, and compile information.
  ///
  /// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext/getShaderInfoLog
  external String getShaderInfoLog(WebGLShader shader);

  /// Returns information about the given shader.
  ///
  /// Possible values of [pname] include:
  /// - [DELETE_STATUS]; returns whether flagged for deletion.
  /// - [COMPILE_STATUS]; retursn if last compile was successful.
  /// - [SHADER_TYPE]; returns either [VERTEX_SHADER] or [FRAGMENT_SHADER].
  ///
  /// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext/getShaderParameter
  external Object getShaderParameter(WebGLShader shader, int pname);

  /// Returns the location of a specific uniform variable part of [program].
  ///
  /// The uniform variable is returned as a [WebGLUniformLocation] object, which
  /// is an opaque identifier used to specify where in the GPU's memory that
  /// uniform variable is located.
  ///
  /// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext/getUniformLocation
  external WebGLUniformLocation? getUniformLocation(
    WebGLProgram program,
    String name,
  );

  /// Completes the process of preparing the GPU code for the program's shaders.
  ///
  /// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext/linkProgram
  external void linkProgram(WebGLProgram program);

  /// Sets the [source] code of a [shader].
  ///
  /// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext/shaderSource
  external void shaderSource(WebGLShader shader, String source);

  /// Specifies a two-dimensional texture image.
  ///
  /// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext/texImage2D
  external void texImage2D(
    int target,
    int level,
    int internalFormat,
    int format,
    int type,
    Object pixels,
  );

  /// Sets texture parameters.
  ///
  /// Possible values of [target] include:
  /// - [TEXTURE_2D]
  /// - [TEXTURE_CUBE_MAP]
  ///
  /// Possible values of [pname] include:
  /// - [TEXTURE_MAG_FILTER]
  /// - [TEXTURE_MIN_FILTER]
  ///
  /// The [param] parameter is a [double] or [int] for the specified parameter.
  ///
  /// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext/texParameter
  external void texParameteri(int target, int pname, num param);

  /// Specifies values of uniform variables.
  ///
  /// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext/uniform
  external void uniform1f(WebGLUniformLocation location, Object textureOrZero);

  /// Specifies values of uniform variables.
  ///
  /// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext/uniform
  external void uniform1i(WebGLUniformLocation location, WebGLTexture texture);

  /// Specifies matrix values for uniform variables.
  ///
  /// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext/uniformMatrix
  external void uniformMatrix4fv(
    WebGLUniformLocation location,
    bool transpose,
    Float32List value,
  );

  /// Specified [program] as part of the current rendering state.
  ///
  /// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext/useProgram
  external void useProgram(WebGLProgram program);

  /// Binds the buffer currently bound to [ARRAY_BUFFER].
  ///
  /// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext/vertexAttribPointer
  external void vertexAttribPointer(
    int index,
    int size,
    int type,
    bool normalized,
    int stride,
    int offset,
  );

  /// Sets the viewport, which specifies device to window coordinates.
  ///
  /// See: https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext/viewport
  external void viewport(num x, num y, num width, num height);
}
