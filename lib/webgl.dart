/// A library that is a _minimal_ Dart facade over WebGL.
///
/// Where possible, this library tries to retain an identical API to the
/// cooresponding [JavaScript API](https://developer.mozilla.org/en-US/docs/Web/API/WebGL_API)
/// but retaining a Dart idiomatic feel (at least, as much as possible).
///
/// ## But, why not use [`dart:web_gl`][]?
///
/// I personally don't like using [undocumented APIs](https://api.dart.dev/stable/2.17.6/dart-web_gl/AngleInstancedArrays-class.html)
/// where I have to constantly reference something else (i.e. MDN) and then
/// [hope][] that the auto-generated Dart binding code works the same as in
/// JavaScript.
///
/// So, this is a tiny, minimal, API with some documentation.
///
/// [`dart:web_gl`]: https://api.dart.dev/stable/2.17.6/dart-web_gl/dart-web_gl-library.html
/// [hope]: https://github.com/dart-lang/sdk/issues?q=is%3Aissue+is%3Aopen+webgl%3B
@experimental
library webgl;

import 'dart:typed_data';

import 'package:js/js.dart';
import 'package:meta/meta.dart';
import 'package:twod/dom.dart';

part 'src/webgl/constants.dart';
part 'src/webgl/context.dart';
part 'src/webgl/extensions.dart';
part 'src/webgl/objects.dart';
