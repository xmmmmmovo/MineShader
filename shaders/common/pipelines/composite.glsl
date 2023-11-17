#include "/common/constants.glsl"
#include "default_vsh.glsl"

// Fragment
// Shader///////////////////////////////////////////////////////////////////////////////////
#ifdef FSH

varying vec2 texCoord;

// Direction of the sun (not normalized!)
uniform vec3 sunPosition;

uniform sampler2D colortex0;
uniform sampler2D colortex1; // normal tex
uniform sampler2D colortex2; // lightmap

const float sunPathRotation = -40.0f;

const float Ambient = 0.025f;

float adjustLMTorch(in float torch) { return 2.0f * pow(torch, 5.06f); }

float adjustLMSky(in float sky) {
  float sky_2 = sky * sky;
  return sky_2 * sky_2;
}

vec2 adjustLightmap(in vec2 lightmap) {
  vec2 newLightMap;
  newLightMap.x = adjustLMTorch(lightmap.x);
  newLightMap.y = adjustLMSky(lightmap.y);
  return newLightMap;
}

vec3 getLMColor(in vec2 lightMap) {
  // First adjust the lightmap
  lightMap = adjustLightmap(lightMap);
  // Color of the torch and sky. The sky color changes depending on time of day
  // but I will ignore that for simplicity
  const vec3 TorchColor = vec3(1.0f, 0.25f, 0.08f);
  const vec3 SkyColor = vec3(0.05f, 0.15f, 0.3f);
  // Multiply each part of the light map with it's color
  vec3 TorchLighting = lightMap.x * TorchColor;
  vec3 SkyLighting = lightMap.y * SkyColor;
  // Add the lighting togther to get the total contribution of the lightmap the
  // final color.
  vec3 lightmapLighting = TorchLighting + SkyLighting;
  // Return the value
  return lightmapLighting;
}

// Program//
void main() {
  vec2 lightmap = texture2D(colortex2, texCoord).rg;
  vec3 lightmapColor = getLMColor(lightmap);

  // Account for gamma correction
  vec3 Albedo = pow(texture2D(colortex0, texCoord).rgb, GAMMA_VEC3);
  // Get the normal
  vec3 Normal = normalize(texture2D(colortex1, texCoord).rgb * 2.0f - 1.0f);
  // Compute cos theta between the normal and sun directions
  float NdotL = max(dot(Normal, normalize(sunPosition)), 0.0f);
  // Do the lighting calculations
  vec3 Diffuse = Albedo * (lightmapColor + NdotL + Ambient);
  /* DRAWBUFFERS:0 */
  // Finally write the diffuse color
  gl_FragData[0] = vec4(Diffuse, 1.0f);
}

#endif
