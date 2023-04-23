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
				// Superior.
				var _lefttt = 0.5+i/L-_Lt;
				var _topt = 0.5+j/L-_Lt;
				var _rightt = 0.5+i/L+_Lt;
				var _bott = 0.5+j/L+_Lt;
				d3dAddQuadraVertexArraySolid(_vtx,
					[x+i-_Lv, y+j+_Lv, z-L/2, _lefttt, _bott, 0,0,-1],
					[x+i-_Lv, y+j-_Lv, z-L/2, _lefttt, _topt, 0,0,-1],
					[x+i+_Lv, y+j+_Lv, z-L/2, _rightt, _bott, 0,0,-1],
					[x+i+_Lv, y+j-_Lv, z-L/2, _rightt, _topt, 0,0,-1]
				);
				
				// Frontal.
				var _lefttt = 0.5+i/L-_Lt;
				var _topt = 0.5+j/L-_Lt;
				var _rightt = 0.5+i/L+_Lt;
				var _bott = 0.5+j/L+_Lt;
				d3dAddQuadraVertexArraySolid(_vtx,
					[x+i-_Lv, y+j+_Lv, z-L/2, _lefttt, _bott, 0,0,-1],
					[x+i-_Lv, y+j-_Lv, z-L/2, _lefttt, _topt, 0,0,-1],
					[x+i+_Lv, y+j+_Lv, z-L/2, _rightt, _bott, 0,0,-1],
					[x+i+_Lv, y+j-_Lv, z-L/2, _rightt, _topt, 0,0,-1]
				);
			}
	}
		
	vertex_end(_vtx);
	vertex_freeze(_vtx);
#endregion