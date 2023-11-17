#include "/common/constants.glsl"
#include "default_vsh.glsl"

// Fragment
// Shader///////////////////////////////////////////////////////////////////////////////////
#ifdef FSH

varying vec2 texCoord;

uniform sampler2D colortex0;

// Optifine Constants//
/*
const int colortex0Format = R11F_G11F_B10F; //main scene
const int colortex1Format = RGB8; //raw translucent, bloom, final scene
const int colortex2Format = RGBA16; //temporal data
const int colortex3Format = RGB8; //specular data
const int gaux1Format = R8; //cloud alpha, ao
const int gaux2Format = RGB10_A2; //reflection image
const int gaux3Format = RGB16; //normals
const int gaux4Format = RGB16; //fresnel
*/

// Program//
void main() {
  vec2 newTexCoord = texCoord;
  vec3 color = pow(texture2DLod(colortex0, texCoord, 0).rgb, vec3(1.0f));
  gl_FragColor = vec4(color, 1.0);
}

#endif
