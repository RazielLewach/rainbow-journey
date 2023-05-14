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
	if (vertexEnvironmentRock != noone and iProgressLoad == -1)
	{
		shader_set(shDefaults);
		setShaderParameterVec(shDefaults,"uMatLight",matLights);
		setShaderParameterInt(shDefaults,"uNLights",nLights);
		setShaderParameterVec(shDefaults,"uOrigin",[0,0,0]);
		setShaderParameterFloat(shDefaults,"uRatLight",oPlayer.ratLight);
		setShaderParameterFloat(shDefaults,"uDirWaterWave",dirWaterWave);
		
		matrix_set(matrix_world,matrixBuildExt(0,0,0, 0, 0, 0, 1,1,1));
		vertex_submit(vertexEnvironmentRock,pr_trianglelist,txEscenarios[0]);
		
		shader_reset();
	}
#endregion
#region Crea el modelo del suelo de roca.
	if (vertexFloorRock == noone and canCreateVertex)
	{
		canCreateVertex = false;
		vertexFloorRock = vertex_create_buffer();
		vertex_begin(vertexFloorRock, vertexFormat);
		
		setArrD3dOpciones(0,0,0,0,0,0,0,1,1,1);	
		for (var i = 0; i < N_TILES; i++)
			for (var j = 0; j < N_TILES; j++)
				d3dAddSolidFloor(i, j, 0,
					-L/2, +L/2, -ROOM_SIZE, 0.0, 1.0,
					-L/2, -L/2, -ROOM_SIZE, 0.0, 0.0,
					+L/2, +L/2, -ROOM_SIZE, 1.0, 1.0,
					+L/2, -L/2, -ROOM_SIZE, 1.0, 0.0
				);
		
		vertex_end(vertexFloorRock);
		vertex_freeze(vertexFloorRock);
	}
#endregion
#region Dibuja el suelo de roca.
	if (vertexFloorRock != noone and oPlayer.z < -ROOM_SIZE)
	{
		shader_set(shDefaults);
		setShaderParameterVec(shDefaults,"uMatLight",matLights);
		setShaderParameterInt(shDefaults,"uNLights",nLights);
		setShaderParameterVec(shDefaults,"uOrigin",[0,0,0]);
		setShaderParameterFloat(shDefaults,"uRatLight",oPlayer.ratLight);
		setShaderParameterFloat(shDefaults,"uDirWaterWave",dirWaterWave);
		
		matrix_set(matrix_world,matrixBuildExt(0,0,0, 0, 0, 0, 1,1,1));
		vertex_submit(vertexFloorRock, pr_trianglelist, txEscenarios[0]);
		
		shader_reset();
	}
#endregion
#region Ajustar matrix.
	matrix_set(matrix_world,matrixBuildExt(0,0,0,0,0,0,1,1,1));
#endregion