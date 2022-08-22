part of '/twod.dart';

/// Helper function for creating texture coordinates.
Float32List _uvs(
  double x,
  double y,
  double w,
  double h,
) =>
    Float32List(4)
      ..[0] = x
      ..[1] = y
      ..[2] = w
      ..[3] = h;

/// Represents a texture being rendererd.
@sealed
class Texture extends Frame {
  /// Creates a texture from a [WebGLTexture].
  ///
  /// May specify an [alpha].
  factory Texture.from(
    WebGLTexture texture, {
    required double width,
    required double height,
    double alpha = 1,
  }) {
    return Texture._asFrame(
      size: Point(width, height),
      anchor: Point(0, 0),
      uvs: _uvs(0, 0, 1, 1),
      alpha: alpha,
      texture: texture,
    );
  }

  Texture._asFrame({
    required super.size,
    required super.anchor,
    required super.uvs,
    required super.alpha,
    required super.texture,
  });

  /// Creates a frame from this texture.
  Frame frame(Point origin, Point size, [Point? anchor]) {
    final width = this.size.x;
    final height = this.size.y;
    return Frame(
      size: size,
      anchor: anchor ?? this.anchor,
      uvs: _uvs(
        origin.x / width,
        origin.y / height,
        size.x / width,
        size.y / height,
      ),
      alpha: alpha,
      texture: texture,
    );
  }
}

/// Represents a frame being rendered from a [Texture].
@sealed
class Frame {
  /// Size of the frame.
  final Point size;

  /// Anchor point for the frame.
  Point anchor;

  /// Texture coordinates.
  final Float32List uvs;

  /// Alpha test.
  final double alpha;

  /// Texture source to draw from.
  final WebGLTexture texture;

  /// Creates a frame from the provided.
  @protected
  Frame({
    required this.size,
    required this.anchor,
    required this.uvs,
    required this.alpha,
    required this.texture,
  });
}
