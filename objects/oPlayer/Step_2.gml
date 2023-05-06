#region Calcula el movimiento.
	// Calcula direcciones.
	var _hTo = 0 + 1*(keyMoveFront()) - 1*(keyMoveBack());
	var _vTo = 0 + 1*(keyMoveRight()) - 1*(keyMoveLeft());
	var _dTo = 0 - 1*(keyMoveUp());
	var _isMoving = _hTo != 0 or _vTo != 0 or _dTo != 0;
	var _coords = matrix_transform_vertex(matrixBuildExt(0,0,0,0,oCamera.dirCamTheta,oCamera.dirCamPhi,1,1,1),_hTo,_vTo,_dTo);
	_hTo = _coords[0];
	_vTo = _coords[1];
	_dTo = _coords[2];
	
	if (_isMoving)
	{
		var _phi = getPhiFromCoords(0,0,_hTo,_vTo);
		var _theta = getThetaFromCoords(0,0,0,_hTo,_vTo,_dTo);
		hSpeed += acceleration*dcos(_phi)*dcos(_theta);
		vSpeed -= acceleration*dsin(_phi)*dcos(_theta);
		dSpeed -= acceleration*dsin(_theta);
		
		dirPhiMoving = _phi;
		dirThetaMoving = _theta;
	}
	
	// Mira a donde se mueve.
	var _scSpd = point_distance_3d(0,0,0,hSpeed,vSpeed,dSpeed)/maxSpeed;
	var _spdRota = acceleration*2*(0.0001 + _scSpd);
	dirPhiLook = dirTiendeAX(dirPhiLook,dirPhiMoving,_spdRota);
	dirThetaLook = dirTiendeAX(dirThetaLook,dirThetaMoving,_spdRota);
	
	// Se ajusta gradualmente hacia donde miras a más parado estás.
	var _spd = 0.0001 + 3*(1-_scSpd);
	dirPhiLook = dirTiendeAX(dirPhiLook,oCamera.dirCamPhi,_spd);
	dirThetaLook = dirTiendeAX(dirThetaLook,oCamera.dirCamTheta,_spd);
#endregion
#region Tiende a frenarse y caer.
	var _phi = getPhiFromCoords(0,0,hSpeed,vSpeed);
	var _theta = getThetaFromCoords(0,0,0,hSpeed,vSpeed,dSpeed);
	hSpeed = tiendeAX(hSpeed,0,abs(dcos(_phi)*dcos(_theta))*brake);
	vSpeed = tiendeAX(vSpeed,0,abs(dsin(_phi)*dcos(_theta))*brake);
	dSpeed = tiendeAX(dSpeed,0,abs(dsin(_theta))*brake);
#endregion
#region Ajusta la velocidad máxima.
	var _phi = getPhiFromCoords(0,0,hSpeed,vSpeed);
	var _theta = getThetaFromCoords(0,0,0,hSpeed,vSpeed,dSpeed);
	var _lon = min(maxSpeed,point_distance_3d(0,0,0,hSpeed,vSpeed,dSpeed));
	hSpeed = +_lon*dcos(_phi)*dcos(_theta);
	vSpeed = -_lon*dsin(_phi)*dcos(_theta);
	dSpeed = -_lon*dsin(_theta);
#endregion
#region Ejecuta el movimiento.
	// Nos movemos o frenamos ante colisión.
	x += hSpeed;
	y += vSpeed;
	z += dSpeed;
	
	// Choca con el suelo.
	if (z+radius*1.1 > 0)
	{
		z -= dSpeed;
		dSpeed = 0;
	}
	
	// Ajústate a la vacuum más cercana.
	var _vac = getNearestVacuum(x, y, z);
	var _lon = _vac.radius-radius;
	if (point_distance_3d(x, y, z, _vac.x, _vac.y, _vac.z) > _lon)
	{
		var _phi = getPhiFromCoords(_vac.x, _vac.y, x, y);
		var _theta = getThetaFromCoords(_vac.x, _vac.y, _vac.z, x, y, z, );
		x = _vac.x + _lon*dcos(_phi)*dcos(_theta);
		y = _vac.y - _lon*dsin(_phi)*dcos(_theta);
		z = _vac.z - _lon*dsin(_theta);
	}
	
	// Animaciones varias.
	spdDirSpeed = tiendeAX(spdDirSpeed,point_distance_3d(0,0,0,hSpeed,vSpeed,dSpeed)/2,1*_isMoving);
	var _spd = spdDirSpeed;
	if (_spd == 0) _spd = brake/5;
	dirSpeed = angular(dirSpeed+_spd);
	
	ratLight = min(1, abs(z)/MAX_WATER_HEIGHT)*0.67;
#endregion
#region Lógica de los tentáculos.
	for (var i = 0; i < array_length(arrTentaculo); ++i)
		with(arrTentaculo[i])
		{
			for (var j = 0; j < array_length(arrXBolas); ++j)
			{
				// Física de las bolas.
				if (j == 0)
				{
					// La primera bola está fija siempre. Es la referencia.
					var _coords = getCoordsBaseTentacle(i,other.radius,other.dirPhiLook,other.dirThetaLook);
					arrXBolas[0] = other.x+_coords[0];
					arrYBolas[0] = other.y+_coords[1];
					arrZBolas[0] = other.z+_coords[2];
				}
				else
				{
					// Movimientos ocasionales.
					if (prob(3))
					{
						var _phi = 0, _theta = 0;
						// La mitad de las veces será random para el fluir de las olas.
						if (prob(80))
						{
							_phi = random(360);
							_theta = random_range(-90,90);
						}
						// La otra mitad vuelve a la posición alineada para no irse a la verga.
						else
						{
							var _lon = SEP_NODE_TENTACLE*j;
							var _xTo = arrXBolas[0] - _lon*dcos(oPlayer.dirPhiLook)*dcos(oPlayer.dirThetaLook);
							var _yTo = arrYBolas[0] + _lon*dsin(oPlayer.dirPhiLook)*dcos(oPlayer.dirThetaLook);
							var _zTo = arrZBolas[0] + _lon*dsin(oPlayer.dirThetaLook);
							_phi = getPhiFromCoords(arrXBolas[j],arrYBolas[j],_xTo,_yTo);
							_theta = getThetaFromCoords(arrXBolas[j],arrYBolas[j],arrZBolas[j],_xTo,_yTo,_zTo);
						}
						
						// Procede.
						var _spd = random(other.maxSpeedWaves/10);
						arrHSpeed[j] = +_spd*dcos(_phi)*dcos(_theta);
						arrVSpeed[j] = -_spd*dsin(_phi)*dcos(_theta);
						arrDSpeed[j] = -_spd*dsin(_theta);
					}
					
					// Gestiona los movimientos random.
					var _phiSlow = getPhiFromCoords(0,0,arrHSpeed[j],arrVSpeed[j]);
					var _thetaSlow = getThetaFromCoords(0,0,0,arrHSpeed[j],arrVSpeed[j],arrDSpeed[j]);
					var _spdSlow = other.maxSpeedWaves/1000;
					arrHSpeed[j] = tiendeAX(arrHSpeed[j],0,_spdSlow*abs(dcos(_phiSlow)*dcos(_thetaSlow)));
					arrVSpeed[j] = tiendeAX(arrVSpeed[j],0,_spdSlow*abs(dsin(_phiSlow)*dcos(_thetaSlow)));
					arrDSpeed[j] = tiendeAX(arrDSpeed[j],0,_spdSlow*abs(dsin(_thetaSlow)));
					var _spdVaiven = 1 + 3*sqrt(other.hSpeed*other.hSpeed + other.vSpeed*other.vSpeed + other.dSpeed*other.dSpeed);
					arrXBolas[j] += _spdVaiven*arrHSpeed[j];
					arrYBolas[j] += _spdVaiven*arrVSpeed[j];
					arrZBolas[j] += _spdVaiven*arrDSpeed[j];
					
					// Se ajusta al padre.
					var _xParent = arrXBolas[j-1];
					var _yParent = arrYBolas[j-1];
					var _zParent = arrZBolas[j-1];
					var _dist = point_distance_3d(arrXBolas[j],arrYBolas[j],arrZBolas[j],_xParent,_yParent,_zParent);
					var _maxSpd = other.maxSpeed*_dist/10;
					var _phi = getPhiFromCoords(_xParent,_yParent,arrXBolas[j],arrYBolas[j]);
					var _theta = getThetaFromCoords(_xParent,_yParent,_zParent,arrXBolas[j],arrYBolas[j],arrZBolas[j]);
					
					// Cerca del punto estable, se asigna.
					if (abs(_dist-SEP_NODE_TENTACLE) <= _maxSpd)
					{
						arrXBolas[j] = _xParent + SEP_NODE_TENTACLE*dcos(_phi)*dcos(_theta);
						arrYBolas[j] = _yParent - SEP_NODE_TENTACLE*dsin(_phi)*dcos(_theta);
						arrZBolas[j] = _zParent - SEP_NODE_TENTACLE*dsin(_theta);
					}
					else
					{
						arrXBolas[j] -= _maxSpd*dcos(_phi)*dcos(_theta);
						arrYBolas[j] += _maxSpd*dsin(_phi)*dcos(_theta);
						arrZBolas[j] += _maxSpd*dsin(_theta);
					}
				}
			}
		}
#endregion