import 'package:twod/dom.dart';

/// Whether assertions are enabled, i.e. we are using DartDevCompiler.
bool get assertionsEnabled {
  var enabled = false;
  // ignore: prefer_asserts_with_message
  assert(enabled = true);
  return enabled;
}

class _Undefined {
  const _Undefined();
}

/// If assertions are enabled, logs the following message(s) to `console.log`.
void debugLog(
  Object? a, [
  Object? b = const _Undefined(),
  Object? c = const _Undefined(),
  Object? d = const _Undefined(),
  Object? e = const _Undefined(),
]) {
  if (!assertionsEnabled) {
    return;
  }
  if (e != const _Undefined()) {
    return window.console.log([a, b, c, d, e]);
  }
  if (d != const _Undefined()) {
    return window.console.log([a, b, c, d]);
  }
  if (c != const _Undefined()) {
    return window.console.log([a, b, c]);
  }
  if (d != const _Undefined()) {
    return window.console.log([a, b]);
  } else {
    return window.console.log(a);
  }
}
