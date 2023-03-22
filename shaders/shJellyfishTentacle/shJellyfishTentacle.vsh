attribute vec3 in_Position;                  // (x,y,z)
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float phi0;
uniform float phi1;
uniform float phi2;
uniform float phi3;
uniform float phi4;
uniform float phi5;
uniform float phi6;
uniform float phi7;
uniform float phi8;
uniform float phi9;
uniform float theta0;
uniform float theta1;
uniform float theta2;
uniform float theta3;
uniform float theta4;
uniform float theta5;
uniform float theta6;
uniform float theta7;
uniform float theta8;
uniform float theta9;

void main()
{
	float _dist = sqrt(in_Position.x*in_Position.x + in_Position.y*in_Position.y + in_Position.z*in_Position.z);
	float _phi = -atan(in_Position.y, in_Position.x);
	float _theta = atan(in_Position.z, in_Position.x);
	
	_phi   += radians(phi0	)*(_dist-000.00)/025.00;
	_theta += radians(theta0)*(_dist-000.00)/025.00;
	if (_dist >= 025.0)
	{
		_phi   += radians(phi1	)*(_dist-025.00)/025.00;
		_theta += radians(theta1)*(_dist-025.00)/025.00;
	}
	if (_dist >= 050.0)
	{
		_phi   += radians(phi2	)*(_dist-050.00)/025.00;
		_theta += radians(theta2)*(_dist-050.00)/025.00;
	}
	if (_dist >= 075.0)
	{
		_phi   += radians(phi3	)*(_dist-075.00)/025.00;
		_theta += radians(theta3)*(_dist-075.00)/025.00;
	}
	if (_dist >= 100.0)
	{
		_phi   += radians(phi4	)*(_dist-100.00)/025.00;
		_theta += radians(theta4)*(_dist-100.00)/025.00;
	}
	if (_dist >= 125.0)
	{
		_phi   += radians(phi5	)*(_dist-125.00)/025.00;
		_theta += radians(theta5)*(_dist-125.00)/025.00;
	}
	if (_dist >= 150.0)
	{
		_phi   += radians(phi6	)*(_dist-150.00)/025.00;
		_theta += radians(theta6)*(_dist-150.00)/025.00;
	}
	if (_dist >= 175.0)
	{
		_phi   += radians(phi7	)*(_dist-175.00)/025.00;
		_theta += radians(theta7)*(_dist-175.00)/025.00;
	}
	if (_dist >= 200.0)
	{
		_phi   += radians(phi8	)*(_dist-200.00)/025.00;
		_theta += radians(theta8)*(_dist-200.00)/025.00;
	}
	if (_dist >= 225.0)
	{
		_phi   += radians(phi9	)*(_dist-225.00)/025.00;
		_theta += radians(theta9)*(_dist-225.00)/025.00;
	}
	
    vec4 object_space_pos = vec4(
		-_dist*cos(_phi)*cos(_theta),
		+_dist*sin(_phi)*cos(_theta),
		+_dist*sin(_theta),
	1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}
