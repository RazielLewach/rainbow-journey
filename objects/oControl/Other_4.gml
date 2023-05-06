#region Crea el vertex del escenario (General).
	if (vertexEscenarioRoca != noone) vertex_delete_buffer(vertexEscenarioRoca);
	vertexEscenarioRoca = vertex_create_buffer();
	var _vtx = vertexEscenarioRoca;
		
	vertex_begin(_vtx, vertexFormat);
	
	// Creamos un array 3D de falses (¿Tiene sólido en esa posición?)
	var _wSize = room_width/L;
	var _hSize = room_height/L;
	var _dSize = MAX_WATER_HEIGHT/L;
	var _arrSolids = array_create(_wSize, false);
	
	// Informamos el array 3D chequeando vacuums.	
	for (var i = 0; i < _wSize; i++)
	{
		_arrSolids[i] = array_create(_hSize, false);
		for (var j = 0; j < _hSize; j++)
		{
			_arrSolids[i][j] = array_create(_dSize, false);
			for (var k = 0; k < _dSize; k++)
			{
				var _vac = getNearestVacuum(i*L, j*L, -k*L);
				if (point_distance_3d(i*L, j*L, -k*L, _vac.x, _vac.y, _vac.z) > _vac.radius) _arrSolids[i][j][k] = true;
			}
		}
	}
			
	// Dibujamos un cubo donde diga el array de solids, pero sólo caras visibles.
	for (var i = 0; i < _wSize; i++)
		for (var j = 0; j < _hSize; j++)
			for (var k = 0; k < _dSize; k++)
				if (_arrSolids[i][j][k])
				{
					setArrD3dOpciones(0,0,0,0,0,0,0,1,1,1);
				
					// Cara frontal, sólo si no hay otro solid en esa dirección.
					if (j != _hSize-1 and !_arrSolids[i][j+1][k])
						d3dAddSolidArray(_vtx, [c_white, c_white, c_white, c_white], 1, i, j, k,
							[-L/2, +L/2, +L/2, 0.0, 1.0],
							[-L/2, +L/2, -L/2, 0.0, 0.0],
							[+L/2, +L/2, +L/2, 1.0, 1.0],
							[+L/2, +L/2, -L/2, 1.0, 0.0]
						)
				
					// Cara trasera, sólo si no hay otro solid en esa dirección.
					if (j != 0 and !_arrSolids[i][j-1][k])
						d3dAddSolidArray(_vtx, [c_white, c_white, c_white, c_white], 1, i, j, k,
							[+L/2, -L/2, +L/2, 0.0, 1.0],
							[+L/2, -L/2, -L/2, 0.0, 0.0],
							[-L/2, -L/2, +L/2, 1.0, 1.0],
							[-L/2, -L/2, -L/2, 1.0, 0.0]
						)
				
					// Cara derecha, sólo si no hay otro solid en esa dirección.
					if (i != _wSize-1 and !_arrSolids[i+1][j][k])
						d3dAddSolidArray(_vtx, [c_white, c_white, c_white, c_white], 1, i, j, k,
							[+L/2, +L/2, +L/2, 0.0, 1.0],
							[+L/2, +L/2, -L/2, 0.0, 0.0],
							[+L/2, -L/2, +L/2, 1.0, 1.0],
							[+L/2, -L/2, -L/2, 1.0, 0.0]
						)
				
					// Cara izquierda, sólo si no hay otro solid en esa dirección.
					if (i != 0 and !_arrSolids[i-1][j][k])
						d3dAddSolidArray(_vtx, [c_white, c_white, c_white, c_white], 1, i, j, k,
							[-L/2, -L/2, +L/2, 0.0, 1.0],
							[-L/2, -L/2, -L/2, 0.0, 0.0],
							[-L/2, +L/2, +L/2, 1.0, 1.0],
							[-L/2, +L/2, -L/2, 1.0, 0.0]
						)
					
					// Cara superior, sólo si no hay otro solid en esa dirección.
					if (k != _dSize-1 and !_arrSolids[i][j][k+1])
						d3dAddSolidArray(_vtx, [c_white, c_white, c_white, c_white], 1, i, j, k,
							[-L/2, +L/2, -L/2, 0.0, 1.0],
							[-L/2, -L/2, -L/2, 0.0, 0.0],
							[+L/2, +L/2, -L/2, 1.0, 1.0],
							[+L/2, -L/2, -L/2, 1.0, 0.0]
						)
				
					// Cara inferior, sólo si no hay otro solid en esa dirección.
					if (k != 0 and !_arrSolids[i][j][k-1])
						d3dAddSolidArray(_vtx, [c_white, c_white, c_white, c_white], 1, i, j, k,
							[-L/2, -L/2, +L/2, 0.0, 1.0],
							[-L/2, +L/2, +L/2, 0.0, 0.0],
							[+L/2, -L/2, +L/2, 1.0, 1.0],
							[+L/2, +L/2, +L/2, 1.0, 0.0]
						)
				}
			
	vertex_end(_vtx);
	vertex_freeze(_vtx);
#endregion














