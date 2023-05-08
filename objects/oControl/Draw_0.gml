#region Modelo 3D de esfera, plantilla.
	if (vertexSphere == noone) {
		vertexSphere = vertex_create_buffer();
		
		vertex_begin(vertexSphere,vertexFormat);
		
	
		setArrD3dOpciones(0,0,0,0,0,0,0,1,1,1);
		d3dAddSphere(vertexSphere,0,0,0,1,-90,+90,true,10,c_white,1,0.0,0.0,1.0,1.0);
		
		vertex_end(vertexSphere);
		vertex_freeze(vertexSphere);
	}
#endregion
#region Dibuja el modelo del escenario.
	if (vertexEscenarioRoca != noone)
	{
		shader_set(shDefaults);
		setShaderParameterVec(shDefaults,"uMatLight",matLights);
		setShaderParameterInt(shDefaults,"uNLights",nLights);
		setShaderParameterVec(shDefaults,"uOrigin",[0,0,0]);
		setShaderParameterFloat(shDefaults,"uRatLight",oPlayer.ratLight);
		setShaderParameterFloat(shDefaults,"uDirWaterWave",dirWaterWave);
		
		matrix_set(matrix_world,matrixBuildExt(0,0,0, 0, 0, 0, 1,1,1));
		vertex_submit(vertexEscenarioRoca,pr_trianglelist,txEscenarios[0]);
		
		shader_reset();
	}
#endregion
#region Ajustar matrix.
	matrix_set(matrix_world,matrixBuildExt(0,0,0,0,0,0,1,1,1));
#endregion