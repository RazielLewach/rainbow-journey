#region Crea el vertex del escenario (General).
	if (vertexEscenarioRoca != noone) vertex_delete_buffer(vertexEscenarioRoca);
	vertexEscenarioRoca = vertex_create_buffer();
	var _vtx = vertexEscenarioRoca;
		
	vertex_begin(_vtx, vertexFormat);
	
	// Todos los sólidos.
	var _Lv = L*0.05, _Lt = 1/20;
	
	with(oSolid)
	{
		// Cada cara mide L y está formada por 10 secciones.
		for (var i = -L*0.45; i <= +L*0.45; i += L*0.1)
			for (var j = -L*0.45; j <= +L*0.45; j += L*0.1)
			{
				var _lefttt = 0.5+i/L-_Lt;
				var _topt = 0.5+j/L-_Lt;
				var _rightt = 0.5+i/L+_Lt;
				var _bott = 0.5+j/L+_Lt;
				
				// Superior.
				if (!solidMeeting(x,y,z-1)) d3dAddQuadraVertexArraySolid(_vtx,
					[x+i-_Lv, y+j+_Lv, z-L/2, _lefttt, _bott, 0,0,-1],
					[x+i-_Lv, y+j-_Lv, z-L/2, _lefttt, _topt, 0,0,-1],
					[x+i+_Lv, y+j+_Lv, z-L/2, _rightt, _bott, 0,0,-1],
					[x+i+_Lv, y+j-_Lv, z-L/2, _rightt, _topt, 0,0,-1]
				);
				
				// Inferior.
				if (!solidMeeting(x,y,z+1)) d3dAddQuadraVertexArraySolid(_vtx,
					[x+i-_Lv, y-j-_Lv, z+L/2, _lefttt, _bott, 0,0,+1],
					[x+i-_Lv, y-j+_Lv, z+L/2, _lefttt, _topt, 0,0,+1],
					[x+i+_Lv, y-j-_Lv, z+L/2, _rightt, _bott, 0,0,+1],
					[x+i+_Lv, y-j+_Lv, z+L/2, _rightt, _topt, 0,0,+1]
				);
				
				// Frontal.
				if (!solidMeeting(x,y+1,z)) d3dAddQuadraVertexArraySolid(_vtx,
					[x+i-_Lv, y+L/2, z+j+_Lv, _lefttt, _bott, 0,+1,0],
					[x+i-_Lv, y+L/2, z+j-_Lv, _lefttt, _topt, 0,+1,0],
					[x+i+_Lv, y+L/2, z+j+_Lv, _rightt, _bott, 0,+1,0],
					[x+i+_Lv, y+L/2, z+j-_Lv, _rightt, _topt, 0,+1,0]
				);
				
				// Trasera.
				if (!solidMeeting(x,y-1,z)) d3dAddQuadraVertexArraySolid(_vtx,
					[x-i+_Lv, y-L/2, z+j+_Lv, _lefttt, _bott, 0,-1,0],
					[x-i+_Lv, y-L/2, z+j-_Lv, _lefttt, _topt, 0,-1,0],
					[x-i-_Lv, y-L/2, z+j+_Lv, _rightt, _bott, 0,-1,0],
					[x-i-_Lv, y-L/2, z+j-_Lv, _rightt, _topt, 0,-1,0]
				);
				
				// Derecha.
				if (!solidMeeting(x+1,y,z)) d3dAddQuadraVertexArraySolid(_vtx,
					[x+L/2, y-i+_Lv, z+j+_Lv, _lefttt, _bott, +1,0,0],
					[x+L/2, y-i+_Lv, z+j-_Lv, _lefttt, _topt, +1,0,0],
					[x+L/2, y-i-_Lv, z+j+_Lv, _rightt, _bott, +1,0,0],
					[x+L/2, y-i-_Lv, z+j-_Lv, _rightt, _topt, +1,0,0]
				);
				
				// Izquierda.
				if (!solidMeeting(x-1,y,z)) d3dAddQuadraVertexArraySolid(_vtx,
					[x-L/2, y+i-_Lv, z+j+_Lv, _lefttt, _bott, -1,0,0],
					[x-L/2, y+i-_Lv, z+j-_Lv, _lefttt, _topt, -1,0,0],
					[x-L/2, y+i+_Lv, z+j+_Lv, _rightt, _bott, -1,0,0],
					[x-L/2, y+i+_Lv, z+j-_Lv, _rightt, _topt, -1,0,0]
				);
			}
	}
		
	vertex_end(_vtx);
	vertex_freeze(_vtx);
#endregion