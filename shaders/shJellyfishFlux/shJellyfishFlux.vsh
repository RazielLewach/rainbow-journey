attribute vec3 in_Position;                  // (x,y,z)
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)
attribute vec3 in_Normal;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3 uLight; // Posición de la luz.
uniform vec3 uOrigin; // Posición del objeto.
uniform float uDirSpeed;
uniform float uRatLight;

void main()
{
	float _lon = sqrt(in_Position.x*in_Position.x+in_Position.y*in_Position.y);
	float _prof = 0.0;
	float _scaling = 0.0;
	
	if (in_Position.z >= 0.0)
	{
		_scaling = cos(radians(uDirSpeed));
		_prof = pow(in_Position.z*0.1,2.0);
		_lon = max(0.0, _lon + _prof*_scaling);
	}
	else
	{
		_scaling = 1.2 + 0.4*cos(radians(uDirSpeed-180.0));
		_lon = max(0.0, _lon*_scaling);
	}

	float _dir = -atan(in_Position.y,in_Position.x);
	vec4 object_space_pos = vec4(
		+_lon*cos(_dir),
		-_lon*sin(_dir),
		in_Position.z-_prof*_scaling*1.0,
	1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION]*object_space_pos;
	
    v_vColour = in_Colour;
	v_vColour.rgb *= max(uRatLight, min(1.0,max(0.0, dot(
		normalize((gm_Matrices[MATRIX_WORLD]*vec4(in_Normal,1.0)).xyz - uOrigin),
		normalize(uLight-(gm_Matrices[MATRIX_WORLD]*object_space_pos).xyz)
	))));
    v_vTexcoord = in_TextureCoord;
}