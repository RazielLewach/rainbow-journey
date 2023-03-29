attribute vec3 in_Position;                  // (x,y,z)
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)
attribute vec3 in_Normal;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3 uLight; // Posición de la luz.
uniform vec3 uOrigin; // Posición del objeto.
uniform float uRatLight;
uniform float uArrPhi[10]; // Aumento de phi de esa sección.
uniform float uArrTheta[10]; // Aumento de theta de esa sección.
uniform float uArrXBase[10]; // Posiciones de las bases en x.
uniform float uArrYBase[10]; // Posiciones de las bases en y.
uniform float uArrZBase[10]; // Posiciones de las bases en z.

void main()
{
	float _alpha = in_Colour.a;
	float _iAlpha = min(9.0, floor(_alpha*10.0))/10.0;
	int _i = int(_iAlpha*10.0);
	float _ratio = (_alpha-_iAlpha)/0.1;
	float _xCheck = in_Position.x;
	float _yCheck = in_Position.y - 25.0*float(_i);
	float _zCheck = in_Position.z;
	float _lonDraw = sqrt(_xCheck*_xCheck + _yCheck*_yCheck + _zCheck*_zCheck);
	float _phi   = -atan(_yCheck, _xCheck) + radians(uArrPhi[_i])*_ratio;
	float _theta = -atan(_zCheck, sqrt(_xCheck*_xCheck + _yCheck*_yCheck)) + radians(uArrTheta[_i])*_ratio;
	
    vec4 object_space_pos = vec4(
		uArrXBase[_i]+_lonDraw*cos(_phi)*cos(_theta),
		uArrYBase[_i]-_lonDraw*sin(_phi)*cos(_theta),
		uArrZBase[_i]-_lonDraw*sin(_theta),
	1.0);
	
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION]*object_space_pos;
	
    v_vColour = in_Colour;
	v_vColour.rgb *= max(uRatLight, min(1.0,max(0.0, dot(
		normalize((gm_Matrices[MATRIX_WORLD]*vec4(in_Normal,1.0)).xyz - uOrigin),
		normalize(uLight-(gm_Matrices[MATRIX_WORLD]*object_space_pos).xyz)
	))));
	v_vColour.a = 1.0;
    v_vTexcoord = in_TextureCoord;
}