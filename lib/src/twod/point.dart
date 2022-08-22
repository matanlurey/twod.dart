part of '/twod.dart';

/// A _mutable_ location in a two-dimensional coordinate system.
class Point {
  /// Position of the point on the x-axis.
  double x;

  /// Position of the point on the y-axis.
  double y;

  /// Creates a new point with the provided [x] and [y] values.
  Point(this.x, [double? y]) : y = y ?? x;
}
