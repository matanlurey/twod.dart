// ignore_for_file: noop_primitive_operations

part of '/twod.dart';

/// Used as [HasWebGLConstants$.FRAGMENT_SHADER] within the [Scene].
///
/// This string is intentionally as small as possible as its inlined in the app.
const _fragmentShader = ''
    'precision mediump float;'
    'uniform sampler2D x;'
    'uniform float j;'
    'varying vec2 v;'
    'varying vec4 i;'
    'void main(){'
    'vec4 c=texture2D(x,v);'
    'gl_FragColor=c*i;'
    'if(j>0.0){'
    'if(c.a<j)discard;'
    'gl_FragColor.a=1.0;};}';

/// Used as [HasWebGLConstants$.VERTEX_SHADER] within the [Scene].
///
/// This string is intentionally as small as possible as its inlined in the app.
const _vertexShader = ''
    'attribute vec2 g;'
    'attribute vec2 a;'
    'attribute vec2 t;'
    'attribute float r;'
    'attribute vec2 s;'
    'attribute vec4 u;'
    'attribute vec4 c;'
    'attribute float z;'
    'uniform mat4 m;'
    'varying vec2 v;'
    'varying vec4 i;'
    'void main(){'
    'v=u.xy+g*u.zw;'
    'i=c.abgr;'
    'vec2 p=(g-a)*s;'
    'float q=cos(r);'
    'float w=sin(r);'
    'p=vec2(p.x*q-p.y*w,p.x*w+p.y*q);'
    'p+=a+t;'
    'gl_Position=m*vec4(p,z,1);'
    '}';

/// Creates the default compiled shaders to use for the [Scene].
WebGLProgram _initializeShaders(WebGLRenderingContext gl) {
  final program = gl.createProgram();
  gl
    ..attachShader(
      program,
      _initializeShader(gl, _vertexShader, gl.VERTEX_SHADER),
    )
    ..attachShader(
      program,
      _initializeShader(gl, _fragmentShader, gl.FRAGMENT_SHADER),
    )
    ..linkProgram(program);
  return program;
}

/// Helper function for creating and compiling a shader within the program.
WebGLShader _initializeShader(
  WebGLRenderingContext gl,
  String source,
  int type,
) {
  assert(
    type == gl.VERTEX_SHADER || type == gl.FRAGMENT_SHADER,
    '$type was not either _gl.VERTEX_SHADER or _gl.FRAGMENT_SHADER',
  );
  final shader = gl.createShader(type);
  gl
    ..shaderSource(shader, source)
    ..compileShader(shader);
  if (gl.getShaderParameter(shader, gl.COMPILE_STATUS) == false) {
    final error = gl.getShaderInfoLog(shader);
    gl.deleteShader(shader);
    throw StateError(error);
  }
  return shader;
}
