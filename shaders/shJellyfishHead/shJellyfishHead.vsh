attribute vec3 in_Position;                  // (x,y,z)
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)
attribute vec3 in_Normal;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float uMatLight[70]; // Posición de la luz.
uniform int uNLights; // Número de luces.
uniform vec3 uOrigin; // Posición del objeto.
uniform float uDirSpeed;
uniform float uDirWaterWave; // Ondea el agua.

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
	vec4 _objectSpacePos = vec4(
		+_lon*cos(_dir),
		-_lon*sin(_dir),
		in_Position.z-_prof*_scaling*1.0,
	1.0);
	
	// Ondeo del agua.
	vec4 _worldViewSpacePos = gm_Matrices[MATRIX_WORLD_VIEW]*_objectSpacePos;
	_worldViewSpacePos.x += 5.0*cos(radians(uDirWaterWave + _worldViewSpacePos.y));
	
	// Inicializa.
    gl_Position = gm_Matrices[MATRIX_PROJECTION]*_worldViewSpacePos;
    v_vColour = in_Colour;
	float _maxRat = 0.0;
	
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
				normalize((gm_Matrices[MATRIX_WORLD]*vec4(in_Normal,1.0)).xyz - uOrigin),
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
	v_vColour.rgb *= vec3(1.0, 1.3, 1.3) * min(_maxRat,1.0);
}