part of '/twod.dart';

/// A tiny implementation of a linked list, used for rendering.
///
/// ## Why not `dart:collection`
///
/// The `LinkedList` implementation in `dart:collection` is both heavier weight
/// than our needs (i.e. does concurrent modification checking), and doesn't
/// have the API we need (i.e. expose the node).
class Sequence<E> {
  /// Value of the node.
  final E value;

  Sequence._(this.value, [this._previous, this._next]);

  /// Previous node, if any.
  ///
  /// Can be modified by using [insertBefore].
  Sequence<E>? get previous => _previous;
  Sequence<E>? _previous;

  /// Next node, if any.
  ///
  /// Can be modified by using [insertAfter].
  Sequence<E>? get next => _next;
  Sequence<E>? _next;

  /// Inserts and returns [value] as a node before this node.
  Sequence<E> insertBefore(E value) {
    // previous <-> inserted <-> this <-> next
    final node = Sequence._(value, _previous, this);

    // If the previous is a node, rewrite next.
    _previous?._next = node;
    _previous = node;
    return node;
  }

  /// Inserts and returns [value] as a node after this node.
  Sequence<E> insertAfter(E value) {
    // previous <-> this <-> inserted <-> next
    final node = Sequence._(value, this, _next);

    // If the next is a node, rewrite previous.
    _next?._previous = node;
    _next = node;
    return node;
  }

  /// Removes and returns the value for this node.
  E remove() {
    final result = value;
    _previous?._next = _next;
    _next?._previous = _previous;
    return result;
  }

  /// Invokes the provided [forEach] callback for each value in order inserted.
  void forEach(void Function(E) forEach) {
    Sequence<E>? node = this;
    while (node != null) {
      forEach(node.value);
      node = node.next;
    }
  }
}
