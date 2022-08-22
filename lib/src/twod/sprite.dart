part of '/twod.dart';

/// A textured 2D object rendered to the screen.
@sealed
class Sprite {
  /// Frame or texture being renderered.
  final Frame frame;

  /// Creates a new sprite from the provided frame or texture.
  Sprite(
    this.frame, {
    double alpha = 1,
    Point? position,
    Point? scale,
    this.rotation = 0,
    this.visible = true,
    this.tint = 0xffffff,
  })  : _alpha = alpha,
        position = position ?? Point(0, 0),
        scale = scale ?? Point(1, 1);

  Sequence<Sprite>? _attachedNode;
  Layer? _attachedToLayer;

  Sequence<Sprite> _attachTo(Layer layer) {
    _attachedNode?.remove();
    _attachedToLayer = layer;
    return _attachedNode = layer._attach(this);
  }

  /// Coordinates to render the sprite to.
  Point position;

  /// Rotation of the sprite in radians.
  double rotation;

  /// Scale factor of the sprite.
  Point scale;

  /// Whether to display.
  bool visible;

  /// Tint applied to the sprite.
  ///
  /// A value of `0xffffff` will remove any tint effect.
  int tint;

  /// Whether the sprite will be rendered completely opaque.
  bool get isOpaque => alpha == 1;

  /// Opacity of the sprite, from `0` to `1`.
  double get alpha => _alpha;
  set alpha(double alpha) {
    _alpha = alpha;

    // If meaningfully changed, remove and re-add the sprite internally.
    if ((alpha == 1) == isOpaque && frame.alpha > 0) {
      _attachedToLayer?.add(this);
    }
  }

  double _alpha;

  /// Removes the sprite, if attached, from it's scene and layer.
  void remove() {
    _attachedNode?.remove();
    _attachedNode = _attachedToLayer = null;
  }
}
