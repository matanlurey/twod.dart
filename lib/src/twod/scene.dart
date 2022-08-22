part of '/twod.dart';

/// Rendering instance for a scene of sprites on an [HTMLCanvasElement].
@sealed
class Scene {
  static const _floatSize = 2 + 2 + 1 + 2 + 4 + 1 + 1;
  static const _byteSize = _floatSize * 4;
  static const _maxBatch = 65535;
  static const _depth = 1e5;

  /// Creates a scene renderer for the provided [canvas].
  ///
  /// [scale] is the resolution multiplier by which the scene is rendered
  /// relative to the [canvas]' resolution. Use `window.devicePixelRatio` for
  /// the highest possible quality, or `1` for the best performance.
  ///
  /// See [WebGL context attributes][].
  ///
  /// [WebGL context attributes]: https://developer.mozilla.org/docs/Web/API/HTMLCanvasElement/getContext
  factory Scene.fromCanvas(
    HTMLCanvasElement canvas, {
    bool alpha = false,
    bool antialias = false,
    int scale = 1,
  }) {
    final gl = WebGLRenderingContext$.fromCanvas(
      canvas,
      alpha: alpha,
      antialias: antialias,
    );
    final extension = gl.getExtension('ANGLE_instanced_arrays');
    if (extension == null) {
      throw UnsupportedError('Extension ANGLE_instanced_arrays not found');
    }
    return Scene._(
      canvas,
      gl,
      scale,
      extension as WebGLAngleInstancedArrays,
      _initializeShaders(gl),
      alpha ? gl.ONE : gl.SRC_ALPHA,
    );
  }

  /// The canvas element.
  final HTMLCanvasElement _canvas;

  /// Web GL context created from [_canvas].
  final WebGLRenderingContext _gl;

  /// Extension created for [_gl] from [_canvas].
  final WebGLAngleInstancedArrays _ext;

  /// Compiled shaders being used for the scene.
  final WebGLProgram _program;

  /// Resolution multiplier relative to the canvas' resolution.
  final int _scale;

  /// The [HasWebGLBlendingModes$] being applied.
  final int _blend;

  Scene._(
    this._canvas,
    this._gl,
    this._scale,
    this._ext,
    this._program,
    this._blend,
  ) {
    // Indices buffer.
    _createBuffer(
      _gl.ELEMENT_ARRAY_BUFFER,
      Uint8List.fromList([0, 1, 2, 2, 1, 3]),
    );

    // Vertex buffer.
    _createBuffer(
      _gl.ARRAY_BUFFER,
      Float32List.fromList([0, 0, 0, 1, 1, 0, 1, 1]),
    );

    // Vertex location.
    _bindAttribute('g', 2);

    // Dynamic buffer.
    _createBuffer(_gl.ARRAY_BUFFER, _buffer, _gl.DYNAMIC_DRAW);

    // Anchor location.
    _bindAttribute('a', 2, _byteSize, 1);

    // Scale location.
    _bindAttribute('s', 2, _byteSize, 1, 8);

    // Rotation location.
    _bindAttribute('r', 1, _byteSize, 1, 16);

    // Translation location.
    _bindAttribute('t', 2, _byteSize, 1, 20);

    // UVS location.
    _bindAttribute('u', 4, _byteSize, 1, 28);

    // Color location.
    _bindAttribute('c', 4, _byteSize, 1, 44, _gl.UNSIGNED_BYTE, true);

    // Z location.
    _bindAttribute('z', 1, _byteSize, 1, 48);

    _matrixLocation = _gl.getUniformLocation(_program, 'm')!;
    _textureLocation = _gl.getUniformLocation(_program, 'x')!;
    _alphaTestLocation = _gl.getUniformLocation(_program, 'j')!;

    // Initialize.
    resize();
  }

  void _bindAttribute(
    String name,
    int size, [
    int stride = 0,
    int? divisor,
    int offset = 0,
    int? type,
    bool normalized = false,
  ]) {
    final location = _gl.getAttribLocation(_program, name);
    _gl
      ..enableVertexAttribArray(location)
      ..vertexAttribPointer(
        location,
        size,
        type ?? _gl.FLOAT,
        normalized,
        stride,
        offset,
      );
    if (divisor != null) {
      _ext.vertexAttribDivisorANGLE(location, divisor);
    }
  }

  void _createBuffer(
    int type,
    TypedData src, [
    int? usage,
  ]) {
    _gl
      ..bindBuffer(type, _gl.createBuffer())
      ..bufferData(type, src, usage ?? _gl.STATIC_DRAW);
  }

  /// Layers within the scene.
  final _layers = [Layer(0)];

  /// Dynamic buffer.
  final _buffer = ByteData(_maxBatch * _byteSize);
  late final _floatView = Float32List.view(_buffer.buffer);
  late final _uintView = Uint32List.view(_buffer.buffer);

  /// Width of the scene.
  late double _width;

  /// Height of the scene.
  late double _height;

  /// Number of sprites that will be drawn on [_flushPendingDrawOperations].
  var _pendingSprites = 0;

  /// Whether alpha test (`alpha = true`) is enabled.
  var _alphaTestMode = false;

  Frame? _currentFrame;
  late final WebGLUniformLocation _textureLocation;
  late final WebGLUniformLocation _alphaTestLocation;
  late final WebGLUniformLocation _matrixLocation;

  /// Where the camera is placed in the scene.
  var cameraOrigin = Point(0, 0);

  /// Where the camera is targeting in the scene.
  var cameraTarget = Point(0, 0);

  /// The angle of the camera from [cameraOrigin] to [cameraTarget].
  var cameraAngle = 0.0;

  /// Resizes the canvas to the current canvas dimensions.
  ///
  /// Returns if a change occurred (i.e. `false` if resizing was a NOP).
  bool resize() {
    final dimensions = _canvas.getBoundingClientRect();
    _width = dimensions.width * _scale;
    _height = dimensions.height * _scale;
    if (_canvas.width != _width || _canvas.height != _height) {
      _canvas
        ..width = _width
        ..height = _height;
      return true;
    }
    return false;
  }

  void _flushPendingDrawOperations() {
    if (_pendingSprites == 0) {
      return;
    }
    final frame = _currentFrame!;

    _gl
      ..blendFunc(
        _alphaTestMode ? _gl.ONE : _blend,
        _alphaTestMode ? _gl.ZERO : _gl.ONE_MINUS_SRC_ALPHA,
      )
      ..depthFunc(_alphaTestMode ? _gl.LESS : _gl.EQUAL)
      ..bindTexture(_gl.TEXTURE_2D, frame.texture)
      ..uniform1i(_textureLocation, frame.texture)
      ..uniform1f(
        _alphaTestLocation,
        _alphaTestMode ? frame.alpha : 0,
      )
      ..bufferSubData(
        _gl.ARRAY_BUFFER,
        0,
        _floatView.sublist(0, _pendingSprites * _floatSize),
      );
    _ext.drawElementsInstancedANGLE(
      _gl.TRIANGLES,
      6,
      _gl.UNSIGNED_BYTE,
      0,
      _pendingSprites,
    );

    _pendingSprites = 0;
  }

  void _drawSprite(Sprite sprite) {
    if (!sprite.visible || sprite.alpha == 0) {
      return;
    }
    if (_pendingSprites == _maxBatch) {
      _flushPendingDrawOperations();
    }
    final frame = sprite.frame;
    final uvs = frame.uvs;
    if (_currentFrame?.texture != frame.texture) {
      if (_currentFrame != null) {
        _flushPendingDrawOperations();
      }
      _currentFrame = frame;
    }
    var i = _pendingSprites * _floatSize;
    _floatView
      ..[i++] = frame.anchor.x
      ..[i++] = frame.anchor.y
      ..[i++] = sprite.scale.x * frame.size.x
      ..[i++] = sprite.scale.y * frame.size.y
      ..[i++] = sprite.rotation
      ..[i++] = sprite.position.x
      ..[i++] = sprite.position.y
      ..[i++] = uvs[0]
      ..[i++] = uvs[1]
      ..[i++] = uvs[2]
      ..[i++] = uvs[3];

    final tint = (sprite.tint & 0xfffffff) << 8;
    final alpha = ((sprite.alpha * 255).toInt() & 255) >>> 0;

    _uintView[i++] = tint | alpha;
    _floatView[i] = sprite._attachedToLayer!.z.toDouble();

    _pendingSprites++;
  }

  /// Renders the current scene.
  ///
  /// This should be invoked in your game loop.
  void render() {
    resize();

    final at = cameraOrigin;
    final to = cameraTarget;

    final x = at.x - _width * to.x;
    final y = at.y - _height * to.y;
    final c = math.cos(cameraAngle);
    final s = math.sin(cameraAngle);
    final w = 2 / _width;
    final h = -2 / _height;

    final projection = Float32List(16)
      ..[0] = c * w
      ..[1] = s * h
      ..[2] = 0
      ..[3] = 0
      ..[4] = -s * w
      ..[5] = c * h
      ..[6] = 0
      ..[7] = 0
      ..[8] = 0
      ..[9] = 0
      ..[10] = -1 / _depth
      ..[11] = 0
      ..[12] = (at.x * (1 - c) + at.y * s) * w - 2 * x / _width - 1
      ..[13] = (at.y * (1 - c) - at.x * s) * h + 2 * y / _height + 1
      ..[14] = 0
      ..[15] = 1;

    _gl
      ..useProgram(_program)
      ..enable(_gl.BLEND)
      ..enable(_gl.DEPTH_TEST)
      ..uniformMatrix4fv(_matrixLocation, false, projection)
      ..viewport(0, 0, _width, _height)
      ..clear(_gl.COLOR_BUFFER_BIT | _gl.DEPTH_BUFFER_BIT);

    _currentFrame = null;
    _alphaTestMode = true;
    for (final layer in _layers) {
      layer.opaque?.forEach(_drawSprite);
    }

    _alphaTestMode = false;
    for (var i = _layers.length - 1; i >= 0; i--) {
      _layers[i].transparent?.forEach(_drawSprite);
    }

    _flushPendingDrawOperations();
  }

  /// If the rendering state is an error, throws.
  void assertNoWebGLErrors() {
    if (_gl.getError() == _gl.NO_ERROR) {
      return;
    }
    // https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext/getError
    throw StateError('WebGL Error: 0x${_gl.getError().toRadixString(16)}');
  }

  /// Sets the background `RGBA` color.
  void setBackground(double r, double g, double b, [double a = 1]) {
    _gl.clearColor(r, g, b, a);
  }

  /// Returns, creating if necessary, a layer within the scene at [zIndex].
  Layer getLayer(int zIndex) {
    return _layers.firstWhere(
      (l) => l.z == zIndex,
      orElse: () {
        final layer = Layer(zIndex);
        _layers
          ..add(layer)
          ..sort((a, b) => b.z - a.z);
        return layer;
      },
    );
  }

  /// Adds [sprite] to the default layer.
  void addSprite(Sprite sprite) {
    _layers.first.add(sprite);
  }

  /// Creates and returns a texture from the provided [canvasOrImage].
  ///
  /// [alphaTest]: The value of the alpha component of the texture pixel below
  /// which the pixel is considered completely transparent and is not displayed.
  /// The pixels with the alpha component equal or greater than `alphaTest` are
  /// displayed opaque.
  ///
  /// When [alphaTest] is `0`, the texture is displayed in blend mode.
  Texture createTexture(
    JSElement canvasOrImage, {
    double alphaTest = 1,
    bool smooth = false,
    bool mipmap = false,
  }) {
    final width = canvasOrImage.width;
    final height = canvasOrImage.height;
    final texture = _gl.createTexture();

    _gl
      ..bindTexture(_gl.TEXTURE_2D, texture)
      ..texParameteri(
        _gl.TEXTURE_2D,
        _gl.TEXTURE_MAG_FILTER,
        _gl.NEAREST | (smooth ? 1 : 0),
      )
      ..texParameteri(
        _gl.TEXTURE_2D,
        _gl.TEXTURE_MIN_FILTER,
        _gl.NEAREST |
            (smooth ? 1 : 0) |
            (mipmap ? 1 : 0) << 8 |
            (mipmap ? 1 : 0) << 1,
      )
      ..texImage2D(
        _gl.TEXTURE_2D,
        0,
        _gl.RGBA,
        _gl.RGBA,
        _gl.UNSIGNED_BYTE,
        canvasOrImage,
      );
    if (mipmap) {
      _gl.generateMipmap(_gl.TEXTURE_2D);
    }
    return Texture.from(
      texture,
      width: width,
      height: height,
      alpha: alphaTest,
    );
  }
}
