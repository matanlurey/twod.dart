part of '/twod.dart';

/// A z-ordered grouping of sprites contained with a scene.
@sealed
class Layer {
  /// The z-index of the layer; the larger, the higher the layer is.
  final int z;

  /// Creates a layer with the provided [z]-index.
  ///
  /// [z] must be >= 0, and should not be an existing layer within a scene.
  Layer(this.z) {
    RangeError.checkNotNegative(z, 'z');
  }

  /// Sprites that are fully opaque.
  Sequence<Sprite>? opaque;

  /// Sprites that are at least partially transparent.
  Sequence<Sprite>? transparent;

  /// Adds [sprite] to the layer.
  ///
  /// If the sprite is already present in another layer, it is removed.
  void add(Sprite sprite) {
    sprite
      ..remove()
      .._attachTo(this);
  }

  Sequence<Sprite> _attach(Sprite sprite) {
    final Sequence<Sprite> result;
    if (sprite.isOpaque) {
      final layer = opaque;
      if (layer == null) {
        result = opaque = Sequence._(sprite);
      } else {
        result = layer.insertAfter(sprite);
      }
    } else {
      final layer = transparent;
      if (layer == null) {
        result = transparent = Sequence._(sprite);
      } else {
        result = layer.insertAfter(sprite);
      }
    }
    return result;
  }
}
