# twod.dart

A tiny webgl 2d sprite renderer for Dart, inspired by [js13k-2d][].

[js13k-2d]: https://github.com/kutuluk/js13k-2d

<!-- ENABLE WHEN PUBLISHED
[![On pub.dev][pub_img]][pub_url]
[![Code coverage][cov_img]][cov_url]
[![Github action status][gha_img]][gha_url]
[![Dartdocs][doc_img]][doc_url]
-->

[![Style guide][sty_img]][sty_url]

[pub_url]: https://pub.dartlang.org/packages/twod
[pub_img]: https://img.shields.io/pub/v/twod%.svg
[gha_url]: https://github.com/neo-dart/twod%/actions
[gha_img]: https://github.com/neo-dart/twod%/workflows/Dart/badge.svg
[cov_url]: https://codecov.io/gh/neo-dart/twod%
[cov_img]: https://codecov.io/gh/neo-dart/twod%/branch/main/graph/badge.svg
[doc_url]: https://www.dartdocs.org/documentation/twod%/latest
[doc_img]: https://img.shields.io/badge/Documentation-twod%-blue.svg
[sty_url]: https://pub.dev/packages/neodart
[sty_img]: https://img.shields.io/badge/style-neodart-9cf.svg

This library provides two libraries: `twod.dart`, a minimal 2D sprite rendering
library built on WebGL, and `webgl.dart`, a minimal Dart interface into using
the [WebGL API](https://web.dev/webgl-fundamentals).

Neither are intended to be a serious framework or used for serious games/apps.

## Usage

NOTE: As of the time of this writing (2022-08-22), this demo does not function.

```sh
make serve
```

...or:

```sh
make build
```
