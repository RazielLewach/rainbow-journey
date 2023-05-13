#region Gestiona el estado.
	// General.
	dirAngular0001 = angular(dirAngular0001+0.01);
	dirAngular0002 = angular(dirAngular0002+0.02);
	dirAngular0003 = angular(dirAngular0003+0.03);
	dirAngular0004 = angular(dirAngular0004+0.04);
	dirAngular0005 = angular(dirAngular0005+0.05);
	dirAngular001 = angular(dirAngular001+0.1);
	dirAngular002 = angular(dirAngular002+0.2);
	dirAngular003 = angular(dirAngular003+0.3);
	dirAngular005 = angular(dirAngular005+0.5);
	dirAngular007 = angular(dirAngular007+0.7);
	dirAngular01 = angular(dirAngular01+01);
	dirAngular02 = angular(dirAngular02+02);
	dirAngular03 = angular(dirAngular03+03);
	dirAngular05 = angular(dirAngular05+05);
	dirAngular10 = angular(dirAngular10+10);
	dirAngular12 = angular(dirAngular12+12);
	nStep++;
	if (nStep >= 600*FPS) nStep = 0;
#endregion
#region Array de luces.
	nLights = 0;
	
	var _xPlayer = oPlayer.x+oPlayer.xDraw;
	var _yPlayer = oPlayer.y+oPlayer.yDraw;
	var _zPlayer = oPlayer.z+oPlayer.zDraw;
	
	// Luz esférica en tu jeto pa alumbrarlo.
	var _lon = 100;
	addMatLight(
		_xPlayer+_lon*dcos(oPlayer.dirPhiLook)*dcos(oPlayer.dirThetaLook),
		_yPlayer-_lon*dsin(oPlayer.dirPhiLook)*dcos(oPlayer.dirThetaLook),
		_zPlayer-_lon*dsin(oPlayer.dirThetaLook),
		_lon, 0, 0, INFINITE
	);
	
	// Luz esférica dentro de ti pa verte.
	_lon = 60;
	addMatLight(
		_xPlayer-_lon*dcos(oPlayer.dirPhiLook)*dcos(oPlayer.dirThetaLook),
		_yPlayer+_lon*dsin(oPlayer.dirPhiLook)*dcos(oPlayer.dirThetaLook),
		_zPlayer+_lon*dsin(oPlayer.dirThetaLook),
		_lon*3, 0, 0, INFINITE
	);
	
	// Luz conal que sale de ti.
	addMatLight(_xPlayer, _yPlayer,_zPlayer, lonLight, oCamera.dirCamPhi, oCamera.dirCamTheta, angLight);
	
	// Todas las luces nomás.
	for (var i = 0; i < instance_number(oLight); ++i)
	{
		var _lig = instance_find(oLight,i);
		addMatLight(_lig.x, _lig.y, _lig.z, _lig.radius, 0, 0, INFINITE);
	}
#endregion
#region Gestión de ondas del agua.
	dirWaterWave = angular(dirWaterWave+1);
#endregion
#region Pantalla de carga: crea los 10 vacuums que harán de salas.
	repeat(iIteratsLoad)
		if (inRange(iProgressLoad, 0, 9))
		{
			// Preparamos los datos del vacuum aleatorio y sus coordenadas.
			var _scale = random_range(3, 5);
			var _radius = _scale*sprite_get_width(sVacuum)/2;
			var _maxRadius = 5*sprite_get_width(sVacuum)/2 + L;
			var _phi = random(360);
			var _lon = random(ROOM_SIZE-_maxRadius);
			var _xPos = ROOM_SIZE/2+_lon*dcos(_phi);
			var _yPos = ROOM_SIZE/2-_lon*dsin(_phi);
			var _zFloor = -_maxRadius - (ROOM_SIZE-_maxRadius*2)*iProgressLoad/9;
		
			// Buscamos un lugar donde no colisione con nadie.
			var _cnt = INFINITE;
			while(_cnt > 0)
			{
				_phi = angular(_phi + 10);
				_xPos = ROOM_SIZE/2+_lon*dcos(_phi);
				_yPos = ROOM_SIZE/2-_lon*dsin(_phi);
				_cnt--;
				var _vacNear = getNearestVacuum(_xPos, _yPos, _zFloor);
				if (_vacNear == noone or point_distance_3d(_xPos, _yPos, _zFloor, _vacNear.x, _vacNear.y, _vacNear.z) > _radius+_vacNear.radius) break;
			}
		
			// Creamos ahí.
			var _vac = create(_xPos, _yPos, _zFloor, oVacuum);
			_vac.image_xscale = _scale;
			_vac.image_yscale = _scale;
			_vac.radius = _radius;
		
			// Finalizamos.
			array_push(arrVacuums, _vac);
			iProgressLoad++;
			nVacuums++;
			textLoading = "Creating vacuums for main rooms";
		}
#endregion
#region Pantalla de carga: define las conexiones necesarias para no aislar ninguna sala.
	if (iProgressLoad == 10)
	{
		// Vamos a recorrer todos los vacuum. Para cada uno, elegimos al azar otra de las salas y las conectamos. Al llegar al final,
		// si queda alguna sala inaccesible, repetimos el proceso. Probablemente quedarán muchas conexiones redundantes, pero es parte del encanto.
		// Si ya existe una conexión entre dos salas, no le añade más.
		
		// Añadimos una conexión aleatoria al vacuum si no somos nosotros mismos y si no existe. También se añade al correspondiente.
		var _idToConnect = arrVacuums[irandom(nVacuums-1)];
		if (_idToConnect != arrVacuums[iRoomSeeksConnection] and !array_contains(arrVacuums[iRoomSeeksConnection].arrIdConnectedTo, _idToConnect))
		{
			array_push(arrVacuums[iRoomSeeksConnection].arrIdConnectedTo, _idToConnect);
			array_push(arrVacuums[iRoomSeeksConnection].arrConnectionProcessed, false);
			array_push(_idToConnect.arrIdConnectedTo, arrVacuums[iRoomSeeksConnection]);
			array_push(_idToConnect.arrConnectionProcessed, false);
			nConnections++;
		}
			
		// Procederemos a chequear el siguiente vacuum.
		iRoomSeeksConnection++;
		if (iRoomSeeksConnection >= nVacuums) iRoomSeeksConnection = 0;
		
		// Chequea si todas las salas son accesibles para continuar.
		var _allRoomsConnected = true;
		for (var i = 1; i < nVacuums; ++i)
		{
			if (!canReachThisVacuum(arrVacuums[i], arrVacuums[0], 0))
			{
				_allRoomsConnected = false;
				break;
			}
		}
		if (_allRoomsConnected) iProgressLoad = 11;
		
		textLoading = "Defining vacuums for tunnels";
	}
#endregion
#region Pantalla de carga: crea los vacuums necesarios en base a las conexiones.
	repeat(iIteratsLoad)
		if (iProgressLoad >= 11 and iProgressLoad <= 10+nConnections)
		{
			// Buscamos hacia adelante, vacuum a vacuum y conexión no procesada a c.n.p. Al encontrar una sin procesar, la procesamos y avanzamos el load.
			var _isFound = false, _iVac = 0, _iCon = 0;
			while(!_isFound)
				// Chequeamos el vacuum...
				with(arrVacuums[_iVac])
				{
					// ... y chequeamos sus conexiones. Si una no está procesada, creamos todos los vacuums que la conforme.
					if (!arrConnectionProcessed[_iCon])
					{
						// Creamos los vacuums.
						var _vacTo = arrIdConnectedTo[_iCon];
						var _radius = sprite_get_width(sVacuum)/2;
						var _phi = getPhiFromCoords(x, y, _vacTo.x, _vacTo.y);
						var _theta = getThetaFromCoords(x, y, z, _vacTo.x, _vacTo.y, _vacTo.z);
						var _offset = _radius*1.5;
						var _xOff = +_offset*dcos(_phi)*dcos(_theta);
						var _yOff = -_offset*dsin(_phi)*dcos(_theta);
						var _zOff = -_offset*dsin(_theta);
						var _xPos = x+radius*dcos(_phi)*dcos(_theta);
						var _yPos = y-radius*dsin(_phi)*dcos(_theta);
						var _zPos = z-radius*dsin(_theta);
						var _lon = point_distance_3d(_xPos, _yPos, _zPos, _vacTo.x, _vacTo.y, _vacTo.z);
					
						var _cnt = INFINITE;
						while(_cnt > 0 and _lon > _vacTo.radius)
						{
							_cnt--;
						
							var _vac = create(_xPos, _yPos, _zPos, oVacuum);
							_vac.image_xscale = 1;
							_vac.image_yscale = 1;
							_vac.radius = _radius;
						
							_xPos += _xOff;
							_yPos += _yOff;
							_zPos += _zOff;
							_lon -= _offset;
						}
					
						// Marcamos ambos lados como procesados.
						arrConnectionProcessed[_iCon] = true;
						for (var i = 0; i < array_length(arrIdConnectedTo[_iCon].arrIdConnectedTo); ++i)
						{
							if (arrIdConnectedTo[_iCon].arrIdConnectedTo[i] == id) arrIdConnectedTo[_iCon].arrConnectionProcessed[i] = true;
						}
						_isFound = true;
					}
					// Si no, pasamos a la siguiente. Pero si se acabaron las conexiones, vamos al próximo vacuum.
					else
					{
						_iCon++;
						if (_iCon == array_length(arrConnectionProcessed))
						{
							++_iVac;
							_iCon = 0;
					
							// Si por milagro del destino llegamos al final de vacuums, seguimos palante.
							if (_iVac == oControl.nVacuums) _isFound = true;
						}
					}
				}
		
			iProgressLoad++;
			textLoading = "Creating vacuums for tunnels";
		}
#endregion
#region Pantalla de carga: posiciona el player.
	if (iProgressLoad == 11+nConnections)
	{
		iProgressLoad++;
		var _vac = arrVacuums[array_length(arrVacuums)-1];
		var _xPre = oPlayer.x, _yPre = oPlayer.y, _zPre = oPlayer.z;
		oPlayer.x = _vac.x;
		oPlayer.y = _vac.y;
		oPlayer.z = _vac.z;
		with(oPlayer) adjustInsideNearestVacuum(0);
		
		for (var i = 0; i < 5; ++i)
			with(oPlayer.arrTentaculo[i])
				for (var j = 0; j <= 10; ++j)
				{
					arrXBolas[j] += (oPlayer.x-_xPre);
					arrYBolas[j] += (oPlayer.y-_yPre);
					arrZBolas[j] += (oPlayer.z-_zPre);
				}		
	
		textLoading = "Starting environment model";
	}
#endregion
#region Pantalla de carga: crea el vertex del escenario, init.
	if (iProgressLoad == 12+nConnections)
	{
		iProgressLoad++;
		if (vertexEscenarioRoca != noone) vertex_delete_buffer(vertexEscenarioRoca);
		vertexEscenarioRoca = vertex_create_buffer();
		
		vertex_begin(vertexEscenarioRoca, vertexFormat);
		
		iLoopLoad = 0;
		jLoopLoad = 0;
		kLoopLoad = 0;
		arrSolids = array_create(N_TILES, false);
		for (var i = 0; i < N_TILES; i++)
		{
			arrSolids[i] = array_create(N_TILES, false);
			for (var j = 0; j < N_TILES; j++) arrSolids[i][j] = array_create(N_TILES, false);
		}
		textLoading = "Calculating solid and vacuum tiles";
	}
#endregion
#region Pantalla de carga: crea el vertex del escenario, colisiones.
	var _iProgressAfterCalculatingSolids = 13+nConnections-1+N_TILES*N_TILES*N_TILES;
	repeat(iIteratsLoad)
		if (iProgressLoad >= 13+nConnections and iProgressLoad <= _iProgressAfterCalculatingSolids)
		{
			var _ratAux = INFINITE;
			for (var i = 0; i < nVacuums; ++i)
			{
				var _iVac = arrVacuums[i];
				var _rat = point_distance_3d(iLoopLoad*L, jLoopLoad*L, -kLoopLoad*L, _iVac.x, _iVac.y, _iVac.z)/_iVac.radius;
				if (_rat < _ratAux) _ratAux = _rat;
			}
			
			if (_ratAux > 1) arrSolids[iLoopLoad][jLoopLoad][kLoopLoad] = true;
			
			iProgressLoad++;
			kLoopLoad++;
			if (kLoopLoad == N_TILES)
			{
				kLoopLoad = 0;
				jLoopLoad++;
				if (jLoopLoad == N_TILES)
				{
					jLoopLoad = 0;
					iLoopLoad++;
					if (iLoopLoad == N_TILES)
					{
						iLoopLoad = 0;
						textLoading = "Creating tile 3D model";
						setArrD3dOpciones(0,0,0,0,0,0,0,1,1,1);
					}
				}
			}
		}
#endregion
#region Pantalla de carga: crea el vertex del escenario, construcción.
	// Dibujamos un cubo donde diga el array de solids, pero sólo caras visibles.
	var _iProgressAfterCreatingSolids = _iProgressAfterCalculatingSolids+1-1+N_TILES*N_TILES*N_TILES;
	repeat(iIteratsLoad)
		if (iProgressLoad >= _iProgressAfterCalculatingSolids+1 and iProgressLoad <= _iProgressAfterCreatingSolids)
		{
			if (arrSolids[iLoopLoad][jLoopLoad][kLoopLoad])
			{
				// Cara frontal, sólo si no hay otro solid en esa dirección.
				if (jLoopLoad != N_TILES-1 and !arrSolids[iLoopLoad][jLoopLoad+1][kLoopLoad])
					d3dAddSolidArray(vertexEscenarioRoca, c_white, 1, iLoopLoad, jLoopLoad, kLoopLoad,
						-L/2, +L/2, +L/2, 0.0, 1.0,
						-L/2, +L/2, -L/2, 0.0, 0.0,
						+L/2, +L/2, +L/2, 1.0, 1.0,
						+L/2, +L/2, -L/2, 1.0, 0.0
					)
				
				// Cara trasera, sólo si no hay otro solid en esa dirección.
				if (jLoopLoad != 0 and !arrSolids[iLoopLoad][jLoopLoad-1][kLoopLoad])
					d3dAddSolidArray(vertexEscenarioRoca, c_white, 1, iLoopLoad, jLoopLoad, kLoopLoad,
						+L/2, -L/2, +L/2, 0.0, 1.0,
						+L/2, -L/2, -L/2, 0.0, 0.0,
						-L/2, -L/2, +L/2, 1.0, 1.0,
						-L/2, -L/2, -L/2, 1.0, 0.0
					)
				
				// Cara derecha, sólo si no hay otro solid en esa dirección.
				if (iLoopLoad != N_TILES-1 and !arrSolids[iLoopLoad+1][jLoopLoad][kLoopLoad])
					d3dAddSolidArray(vertexEscenarioRoca, c_white, 1, iLoopLoad, jLoopLoad, kLoopLoad,
						+L/2, +L/2, +L/2, 0.0, 1.0,
						+L/2, +L/2, -L/2, 0.0, 0.0,
						+L/2, -L/2, +L/2, 1.0, 1.0,
						+L/2, -L/2, -L/2, 1.0, 0.0
					)
				
				// Cara izquierda, sólo si no hay otro solid en esa dirección.
				if (iLoopLoad != 0 and !arrSolids[iLoopLoad-1][jLoopLoad][kLoopLoad])
					d3dAddSolidArray(vertexEscenarioRoca, c_white, 1, iLoopLoad, jLoopLoad, kLoopLoad,
						-L/2, -L/2, +L/2, 0.0, 1.0,
						-L/2, -L/2, -L/2, 0.0, 0.0,
						-L/2, +L/2, +L/2, 1.0, 1.0,
						-L/2, +L/2, -L/2, 1.0, 0.0
					)
					
				// Cara superior, sólo si no hay otro solid en esa dirección.
				if (kLoopLoad != N_TILES-1 and !arrSolids[iLoopLoad][jLoopLoad][kLoopLoad+1])
					d3dAddSolidArray(vertexEscenarioRoca, c_white, 1, iLoopLoad, jLoopLoad, kLoopLoad,
						-L/2, +L/2, -L/2, 0.0, 1.0,
						-L/2, -L/2, -L/2, 0.0, 0.0,
						+L/2, +L/2, -L/2, 1.0, 1.0,
						+L/2, -L/2, -L/2, 1.0, 0.0
					)
				
				// Cara inferior, sólo si no hay otro solid en esa dirección.
				if (kLoopLoad != 0 and !arrSolids[iLoopLoad][jLoopLoad][kLoopLoad-1])
					d3dAddSolidArray(vertexEscenarioRoca, c_white, 1, iLoopLoad, jLoopLoad, kLoopLoad,
						-L/2, -L/2, +L/2, 0.0, 1.0,
						-L/2, +L/2, +L/2, 0.0, 0.0,
						+L/2, -L/2, +L/2, 1.0, 1.0,
						+L/2, +L/2, +L/2, 1.0, 0.0
					)
			}
		
			iProgressLoad++;
			kLoopLoad++;
			if (kLoopLoad == N_TILES)
			{
				kLoopLoad = 0;
				jLoopLoad++;
				if (jLoopLoad == N_TILES)
				{
					jLoopLoad = 0;
					iLoopLoad++;
					if (iLoopLoad == N_TILES)
					{
						iLoopLoad = 0;
					}
				}
			}
		}
#endregion
#region Pantalla de carga: crea el vertex del escenario, end.
	iFinalProgress = _iProgressAfterCreatingSolids+1;
	if (iProgressLoad == iFinalProgress)
	{
		iProgressLoad = -1;
		iIteratsLoad = 1;
		vertex_end(vertexEscenarioRoca);
		vertex_freeze(vertexEscenarioRoca);
		textLoading = "Ending 3D environment model creation";
		gc_collect();
	}
#endregion
#region Calcula el número de iteraciones según carga.
	if (iProgressLoad >= 0)
	{
		if (fps_real > 60) iIteratsLoad += 10;
		else iIteratsLoad = max(iIteratsLoad-20, 1);
	}
#endregion