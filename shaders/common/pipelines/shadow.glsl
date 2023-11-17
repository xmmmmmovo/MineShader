#include "/common/constants.glsl"

// Fragment
// Shader///////////////////////////////////////////////////////////////////////////////////
#ifdef FSH

void main() {}

#endif

#ifdef VSH

void main() { gl_Position = ftransform(); }

#endif