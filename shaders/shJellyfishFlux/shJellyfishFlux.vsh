attribute vec3 in_Position;                  // (x,y,z)
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float dirSpeed;

void main()
{
	float _lon = sqrt(in_Position.x*in_Position.x+in_Position.y*in_Position.y);
	float _prof = 0.0;
	float _scaling = 0.0;
	
	if (in_Position.z >= 0.0)
	{
		_scaling = cos(radians(dirSpeed));
		_prof = pow(in_Position.z*0.1,2.0);
		_lon = max(0.0, _lon + _prof*_scaling);
	}
	else
	{
		_scaling = 1.2 + 0.4*cos(radians(dirSpeed-180.0));
		_lon = max(0.0, _lon*_scaling);
	}

	float _dir = -atan(in_Position.y,in_Position.x);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * vec4(
		+_lon*cos(_dir),
		-_lon*sin(_dir),
		in_Position.z-_prof*_scaling*1.0,
	1.0);
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}
