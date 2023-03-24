attribute vec3 in_Position;                  // (x,y,z)
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)
attribute vec3 in_Normal;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3 uLight; // Posición de la luz.
uniform vec3 uOrigin; // Posición del objeto.
uniform float uRatLight;
uniform float uPhi0;
uniform float uPhi1;
uniform float uPhi2;
uniform float uPhi3;
uniform float uPhi4;
uniform float uPhi5;
uniform float uPhi6;
uniform float uPhi7;
uniform float uPhi8;
uniform float uPhi9;
uniform float uTheta0;
uniform float uTheta1;
uniform float uTheta2;
uniform float uTheta3;
uniform float uTheta4;
uniform float uTheta5;
uniform float uTheta6;
uniform float uTheta7;
uniform float uTheta8;
uniform float uTheta9;

void main()
{
	float _dist = sqrt(in_Position.x*in_Position.x + in_Position.y*in_Position.y + in_Position.z*in_Position.z);
	float _phi = -atan(in_Position.y, in_Position.x);
	float _theta = -atan(in_Position.z, sqrt(in_Position.x*in_Position.x + in_Position.y*in_Position.y));
	
	_phi   += radians(uPhi0	)*(_dist-000.00)/025.00;
	_theta += radians(uTheta0)*(_dist-000.00)/025.00;
	if (_dist >= 025.0)
	{
		_phi   += radians(uPhi1	)*(_dist-025.00)/025.00;
		_theta += radians(uTheta1)*(_dist-025.00)/025.00;
	}
	if (_dist >= 050.0)
	{
		_phi   += radians(uPhi2	)*(_dist-050.00)/025.00;
		_theta += radians(uTheta2)*(_dist-050.00)/025.00;
	}
	if (_dist >= 075.0)
	{
		_phi   += radians(uPhi3	)*(_dist-075.00)/025.00;
		_theta += radians(uTheta3)*(_dist-075.00)/025.00;
	}
	if (_dist >= 100.0)
	{
		_phi   += radians(uPhi4	)*(_dist-100.00)/025.00;
		_theta += radians(uTheta4)*(_dist-100.00)/025.00;
	}
	if (_dist >= 125.0)
	{
		_phi   += radians(uPhi5	)*(_dist-125.00)/025.00;
		_theta += radians(uTheta5)*(_dist-125.00)/025.00;
	}
	if (_dist >= 150.0)
	{
		_phi   += radians(uPhi6	)*(_dist-150.00)/025.00;
		_theta += radians(uTheta6)*(_dist-150.00)/025.00;
	}
	if (_dist >= 175.0)
	{
		_phi   += radians(uPhi7	)*(_dist-175.00)/025.00;
		_theta += radians(uTheta7)*(_dist-175.00)/025.00;
	}
	if (_dist >= 200.0)
	{
		_phi   += radians(uPhi8	)*(_dist-200.00)/025.00;
		_theta += radians(uTheta8)*(_dist-200.00)/025.00;
	}
	if (_dist >= 225.0)
	{
		_phi   += radians(uPhi9	)*(_dist-225.00)/025.00;
		_theta += radians(uTheta9)*(_dist-225.00)/025.00;
	}
	
    vec4 object_space_pos = vec4(
		+_dist*cos(_phi)*cos(_theta),
		-_dist*sin(_phi)*cos(_theta),
		-_dist*sin(_theta),
	1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION]*object_space_pos;
    
    v_vColour = in_Colour;
	v_vColour.rgb *= max(uRatLight, min(1.0,max(0.0, dot(
		normalize((gm_Matrices[MATRIX_WORLD]*vec4(in_Normal,1.0)).xyz - uOrigin),
		normalize(uLight-(gm_Matrices[MATRIX_WORLD]*object_space_pos).xyz)
	))));
    v_vTexcoord = in_TextureCoord;
}