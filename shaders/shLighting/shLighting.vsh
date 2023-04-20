attribute vec3 in_Position;                  // (x,y,z)
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)
attribute vec3 in_Normal;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3 uLight; // Posición de la luz.
uniform vec3 uOrigin; // Posición del objeto.
uniform float uRatLight;

void main()
{
	vec4 _objectSpacePos = vec4(in_Position.x,in_Position.y,in_Position.z,1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION]*_objectSpacePos;
	
    v_vColour = in_Colour;
	v_vColour.rgb *= max(uRatLight, min(1.0,max(0.0, dot(
		normalize((gm_Matrices[MATRIX_WORLD]*vec4(in_Normal,1.0)).xyz - uOrigin),
		normalize(uLight-(gm_Matrices[MATRIX_WORLD]*_objectSpacePos).xyz)
	))));
    v_vTexcoord = in_TextureCoord;
}