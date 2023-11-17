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

const float sunPathRotation = -40.0f;

const float Ambient = 0.6f;

// Program//
void main() {
  // Account for gamma correction
  vec3 Albedo = pow(texture2D(colortex0, texCoord).rgb, vec3(2.2f));
  // Get the normal
  vec3 Normal = normalize(texture2D(colortex1, texCoord).rgb * 2.0f - 1.0f);
  // Compute cos theta between the normal and sun directions
  float NdotL = max(dot(Normal, normalize(sunPosition)), 0.0f);
  // Do the lighting calculations
  vec3 Diffuse = Albedo * (NdotL + Ambient);
  /* DRAWBUFFERS:0 */
  // Finally write the diffuse color
  gl_FragData[0] = vec4(Diffuse, 1.0f);
}

#endif
