//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float xOrigin;
uniform float yOrigin;
uniform float zOrigin;
uniform float scaling;

void main()
{
	float _xMas = in_Position.x-xOrigin;
	float _yMas = in_Position.y-yOrigin;
	float _lon = sqrt(pow(_xMas,2.0)+pow(_yMas,2.0)) * scaling;
	float _dir = atan(_yMas/_xMas);
	float _xPos = in_Position.x + _lon*cos(radians(_dir));
	float _yPos = in_Position.y - _lon*sin(radians(_dir));
    vec4 object_space_pos = vec4(
		_xPos,
		_yPos,
		in_Position.z,
	1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}
