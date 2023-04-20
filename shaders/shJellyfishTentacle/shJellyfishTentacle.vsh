attribute vec3 in_Position;                  // (x,y,z)
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)
attribute vec3 in_Normal;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3 uArrLight; // Posición de la luz.
uniform float uRatLight;
uniform float uArrXBolas[11]; // Posiciones de las bolas en x.
uniform float uArrYBolas[11]; // Posiciones de las bolas en y.
uniform float uArrZBolas[11]; // Posiciones de las bolas en z.

void main()
{
	// Para cada vértice, miramos a qué nodo pertenece, y sacamos los ángulos phi y theta al próximo para ver cuánto nos torcemos.
	int _i = int(in_Colour.a*10.0 + 0.05);
	float _xPositionOffset = in_Position.x - 25.0*float(_i);
	float _xSoporteBola = uArrXBolas[_i+1] - uArrXBolas[_i];
	float _ySoporteBola = uArrYBolas[_i+1] - uArrYBolas[_i];
	float _zSoporteBola = uArrZBolas[_i+1] - uArrZBolas[_i];
	float _phiBolaVertex   = - atan(_ySoporteBola, _xSoporteBola);
	float _thetaBolaVertex = - atan(_zSoporteBola, sqrt(_xSoporteBola*_xSoporteBola + _ySoporteBola*_ySoporteBola));
	
	mat4 _transformMatrix = mat4(
		vec4(cos(_phiBolaVertex), -sin(_phiBolaVertex), 0.0, 0.0),
		vec4(sin(_phiBolaVertex),  cos(_phiBolaVertex), 0.0, 0.0),
		vec4(0.0                , 0.0                 , 1.0, 0.0),
		vec4(0.0                , 0.0                 , 0.0, 1.0)
	) * mat4(
		vec4(cos(-_thetaBolaVertex) , 0.0, sin(-_thetaBolaVertex), 0.0),
		vec4(0.0                   , 1.0, 0.0                  , 0.0),
		vec4(-sin(-_thetaBolaVertex), 0.0, cos(-_thetaBolaVertex), 0.0),
		vec4(0.0                   , 0.0, 0.0                  , 1.0)
	);
	
	vec4 _posFinal = _transformMatrix * vec4(0.0, in_Position.y, in_Position.z, 1.0);
	
	vec4 _objectSpacePos = vec4(
		uArrXBolas[_i]-uArrXBolas[0] + _posFinal.x + _xPositionOffset*cos(_phiBolaVertex)*cos(_thetaBolaVertex),
		uArrYBolas[_i]-uArrYBolas[0] + _posFinal.y - _xPositionOffset*sin(_phiBolaVertex)*cos(_thetaBolaVertex),
		uArrZBolas[_i]-uArrZBolas[0] + _posFinal.z - _xPositionOffset*sin(_thetaBolaVertex),
	1.0);
	
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION]*_objectSpacePos;
	
    v_vColour = vec4(in_Colour.rgb, 1.0);
	v_vColour.rgb *= max(uRatLight, min(1.0,max(0.0, dot(
		normalize((gm_Matrices[MATRIX_WORLD]*_transformMatrix*vec4(in_Normal,1.0)).xyz - vec3(uArrXBolas[0], uArrYBolas[0], uArrZBolas[0])),
		normalize(uArrLight-(gm_Matrices[MATRIX_WORLD]*_objectSpacePos).xyz)
	))));
    v_vTexcoord = in_TextureCoord;
}