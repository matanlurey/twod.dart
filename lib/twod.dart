/// A fast minimal 2D sprite renderer, ported from [js13k-2d][].
///
/// This library is under development and should be considered unstable.
///
/// [js13k-2d]: https://github.com/kutuluk/js13k-2d
@experimental
library twod;

import 'dart:math' as math;
import 'dart:typed_data';

import 'package:meta/meta.dart';
import 'package:twod/dom.dart';
import 'package:twod/webgl.dart';

part 'src/twod/frame.dart';
part 'src/twod/layer.dart';
part 'src/twod/sequence.dart';
part 'src/twod/point.dart';
part 'src/twod/scene.dart';
part 'src/twod/shaders.dart';
part 'src/twod/sprite.dart';
