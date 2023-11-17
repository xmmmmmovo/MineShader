#include "/common/constants.glsl"

// Fragment
// Shader///////////////////////////////////////////////////////////////////////////////////
#ifdef FSH

varying vec2 texCoords;
varying vec2 lightmapCoords;
varying vec3 normal;
varying vec4 color;

// The texture atlas
uniform sampler2D texture;

void main() {
  // Sample from texture atlas and account for biome color + ambien occlusion
  vec4 albedo = texture2D(texture, texCoords) * color;
  /* DRAWBUFFERS:01 */
  // Write the values to the color textures
  gl_FragData[0] = albedo;
  gl_FragData[1] = vec4(normal * 0.5f + 0.5f, 1.0f);
  gl_FragData[2] = vec4(lightmapCoords, 0.0f, 1.0f);
}

#endif

#ifdef VSH

varying vec2 texCoords;
varying vec2 lightmapCoords;
varying vec3 normal;
varying vec4 color;

void main() {
  // Transform the vertex
  gl_Position = ftransform();
  // Assign values to varying variables
  texCoords = gl_MultiTexCoord0.st;
  lightmapCoords = mat2(gl_TextureMatrix[1]) * gl_MultiTexCoord1.st;
  lightmapCoords = (lightmapCoords * 33.05f / 32.0f) - (1.05f / 32.0f);
  normal = gl_NormalMatrix * gl_Normal;
  color = gl_Color;
}

#endif