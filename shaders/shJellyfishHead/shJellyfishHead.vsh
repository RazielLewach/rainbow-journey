attribute vec3 in_Position;                  // (x,y,z)
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)
attribute vec3 in_Normal;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float uMatLight[40]; // Posición de la luz.
uniform int uNLights; // Número de luces.
uniform vec3 uOrigin; // Posición del objeto.
uniform float uDirSpeed;
uniform float uRatLight;

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
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION]*_objectSpacePos;
	
	// Inicializa.
    v_vColour = in_Colour;
	float _maxRat = uRatLight;
	
	// Itera todas las luces y suma el factor.
	for (int i = 0; i < uNLights; ++i)
	{
		vec3 _vertexToLight = vec3(uMatLight[4*i + 0],uMatLight[4*i + 1],uMatLight[4*i + 2])-(gm_Matrices[MATRIX_WORLD]*_objectSpacePos).xyz;
		_maxRat +=	min(1.0,max(0.0, dot(
						normalize((gm_Matrices[MATRIX_WORLD]*vec4(in_Normal,1.0)).xyz - uOrigin),
						normalize(vec3(uMatLight[4*i + 0],uMatLight[4*i + 1],uMatLight[4*i + 2])-(gm_Matrices[MATRIX_WORLD]*_objectSpacePos).xyz)
					))) * (1.0 - min(1.0, sqrt(
							_vertexToLight.x*_vertexToLight.x +
							_vertexToLight.y*_vertexToLight.y +
							_vertexToLight.z*_vertexToLight.z
						)/uMatLight[4*i + 3]));
	}
	
	// Aplica.
	v_vColour.rgb *= min(_maxRat,1.0);
    v_vTexcoord = in_TextureCoord;
}