attribute vec3 in_Position;                  // (x,y,z)
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)
attribute vec3 in_Normal;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3 uArrLight; // Posición de la luz.
uniform vec3 uArrOrigin; // Posición del objeto.
uniform float uRatLight;
uniform vec3 uArrPlayer; // Posición del player.
uniform float uArrXBolas[11]; // Posiciones de las bolas en x.
uniform float uArrYBolas[11]; // Posiciones de las bolas en y.
uniform float uArrZBolas[11]; // Posiciones de las bolas en z.

void main()
{
	// Para cada vértice, miramos a qué nodo pertenece, y sacamos los ángulos phi y theta al próximo para ver cuánto nos torcemos.
	int _i = int(floor(max(0.0,in_Colour.a-0.001)*10.0));
	float _phiLook = 0.0, _thetaLook = 0.0;
	if (_i <= 9)
	{
		float _xCheck = uArrXBolas[_i+1] - uArrXBolas[_i];
		float _yCheck = uArrYBolas[_i+1] - uArrYBolas[_i];
		float _zCheck = uArrZBolas[_i+1] - uArrZBolas[_i];
		_phiLook   = atan(_yCheck, _xCheck);
		_thetaLook = atan(_zCheck, sqrt(_xCheck*_xCheck + _yCheck*_yCheck));
	}
	float _xIni = 25.0*float(_i);
	float _xCheck = in_Position.x - _xIni;
	float _lonDraw = sqrt(_xCheck*_xCheck + in_Position.y*in_Position.y + in_Position.z*in_Position.z);
	float _phi   = atan(in_Position.y, _xCheck) - _phiLook;
	float _theta = atan(in_Position.z, sqrt(_xCheck*_xCheck + in_Position.y*in_Position.y)) - _thetaLook;
	
	// Ejecuta.
    vec4 _objectSpacePos = vec4(
		uArrXBolas[_i]-uArrXBolas[0] + _lonDraw*cos(_phi)*cos(_theta),
		uArrYBolas[_i]-uArrYBolas[0] - _lonDraw*sin(_phi)*cos(_theta),
		uArrZBolas[_i]-uArrZBolas[0] - _lonDraw*sin(_theta),
	1.0);
	
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION]*_objectSpacePos;
	
    v_vColour = in_Colour;
	v_vColour.rgb *= max(uRatLight, min(1.0,max(0.0, dot(
		normalize((gm_Matrices[MATRIX_WORLD]*vec4(in_Normal,1.0)).xyz - vec3(uArrXBolas[0], uArrYBolas[0], uArrZBolas[0])),
		normalize(uArrLight-(gm_Matrices[MATRIX_WORLD]*_objectSpacePos).xyz)
	))));
	v_vColour.a = 1.0;
    v_vTexcoord = in_TextureCoord;
}