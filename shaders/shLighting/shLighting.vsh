attribute vec3 in_Position;                  // (x,y,z)
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)
attribute vec3 in_Normal;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float uMatLight[70]; // Posición de la luz.
uniform int uNLights; // Número de luces.
uniform vec3 uOrigin; // Posición del objeto.
uniform float uRatLight;

void main()
{
	vec4 _objectSpacePos = vec4(in_Position.x,in_Position.y,in_Position.z,1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION]*_objectSpacePos;
	
    // Inicializa.
    v_vColour = in_Colour;
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
				normalize((gm_Matrices[MATRIX_WORLD]*vec4(in_Normal,1.0)).xyz - uOrigin),
				normalize(_vertexToLight)
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
	
	// Aplica.
	v_vColour.rgb *= min(_maxRat,1.0);
    v_vTexcoord = in_TextureCoord;
}