attribute vec3 in_Position;                  // (x,y,z)
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)
attribute vec3 in_Normal;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float uMatLight[70]; // Posición de la luz.
uniform int uNLights; // Número de luces.
uniform float uRatLight; // Oscuridad por profundidad.
uniform float uDirWaterWave; // Ondea el agua.
uniform float uArrXBolas[11]; // Posiciones de las bolas en x.
uniform float uArrYBolas[11]; // Posiciones de las bolas en y.
uniform float uArrZBolas[11]; // Posiciones de las bolas en z.
uniform float uExtraOrigin[3]; // Desplazamiento extra origen.

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
	
	// Ondeo del agua.
	vec4 _worldViewSpacePos = gm_Matrices[MATRIX_WORLD_VIEW]*_objectSpacePos;
	_worldViewSpacePos.x += 5.0*cos(radians(uDirWaterWave + _worldViewSpacePos.y));
	
	// Inicializa.
    gl_Position = gm_Matrices[MATRIX_PROJECTION]*_worldViewSpacePos;
    v_vColour = vec4(in_Colour.rgb, 1.0);
	float _maxRat = uRatLight;
	
	// Itera todas las luces y suma el factor.
	for (int i = 0; i < uNLights; ++i)
	{
		vec3 _vLight = vec3(
			+cos(radians(uMatLight[7*i + 4]))*cos(radians(uMatLight[7*i + 5])),
			-sin(radians(uMatLight[7*i + 4]))*cos(radians(uMatLight[7*i + 5])),
			-sin(radians(uMatLight[7*i + 5]))
		);
		vec3 _vertexToLight = vec3(uMatLight[7*i + 0],uMatLight[7*i + 1],uMatLight[7*i + 2])-(gm_Matrices[MATRIX_WORLD]*_objectSpacePos).xyz;
		
		_maxRat +=
			// Ángulo incidencia de la luz al vértice.
			min(1.0,max(0.0, dot(
				normalize((	gm_Matrices[MATRIX_WORLD]*_transformMatrix*vec4(in_Normal,1.0)).xyz -
							vec3(uArrXBolas[0]+uExtraOrigin[0], uArrYBolas[0]+uExtraOrigin[1], uArrZBolas[0]+uExtraOrigin[2]
				)),
				normalize(vec3(uMatLight[7*i + 0],uMatLight[7*i + 1],uMatLight[7*i + 2])-(gm_Matrices[MATRIX_WORLD]*_objectSpacePos).xyz)
			)))
			*
			// Distancia al foco de luz.
			(1.0 - min(1.0, sqrt(
				_vertexToLight.x*_vertexToLight.x +
				_vertexToLight.y*_vertexToLight.y +
				_vertexToLight.z*_vertexToLight.z
			)/uMatLight[7*i + 3]))
			*
			// Ángulo de incidencia de la dirección de la luz al vértice en luces conales.
			(3.0 - min(3.0, 3.0*degrees(acos(dot(_vLight,-_vertexToLight)/(
				sqrt(_vLight.x*_vLight.x + _vLight.y*_vLight.y + _vLight.z*_vLight.z) *
				sqrt(_vertexToLight.x*_vertexToLight.x + _vertexToLight.y*_vertexToLight.y + _vertexToLight.z*_vertexToLight.z)
			)))/uMatLight[7*i + 6]));
	}
	
	// Coordenadas de textura.
    v_vTexcoord = in_TextureCoord;
	
	// Colorea el tono del agua y la luz.
	v_vColour.rgb += vec3(0.0, 0.5, 0.5);
	float _max = max(v_vColour.r, max(v_vColour.g, v_vColour.b));
	v_vColour.rgb /= _max;
	v_vColour.rgb *= min(_maxRat,1.0);
}