// Vertex
// Shader/////////////////////////////////////////////////////////////////////////////////////
#ifdef VSH

// Varyings//
varying vec2 texCoord;

// Program//
void main() {
  gl_Position = ftransform();
  texCoord = gl_MultiTexCoord0.st;
}

#endif