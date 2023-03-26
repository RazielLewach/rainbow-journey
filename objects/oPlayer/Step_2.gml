#region Calcula el movimiento.
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
		var _phi = point_direction(0,0,_hTo,_vTo);
		var _theta = point_direction(0,0,point_distance(0,0,_hTo,_vTo),_dTo);
		hSpeed += acceleration*dcos(_phi)*dcos(_theta);
		vSpeed -= acceleration*dsin(_phi)*dcos(_theta);
		dSpeed -= acceleration*dsin(_theta);
		
		if (_hTo != 0 or _vTo != 0)
			dirPhiLook = dirTiendeAX(dirPhiLook,_phi,acceleration*2);
		if (_isMoving)
			dirThetaLook = dirTiendeAX(dirThetaLook,_theta,acceleration*2);
	}
#endregion
#region Tiende a frenarse y caer.
	var _phi = point_direction(0,0,hSpeed,vSpeed);
	var _theta = point_direction(0,0,point_distance(0,0,hSpeed,vSpeed),dSpeed);
	hSpeed = tiendeAX(hSpeed,0,abs(dcos(_phi)*dcos(_theta))*brake);
	vSpeed = tiendeAX(vSpeed,0,abs(dsin(_phi)*dcos(_theta))*brake);
	dSpeed = tiendeAX(dSpeed,0,abs(dsin(_theta))*brake);
#endregion
#region Ajusta la velocidad máxima.
	var _phi = point_direction(0,0,hSpeed,vSpeed);
	var _theta = point_direction(0,0,point_distance(0,0,hSpeed,vSpeed),dSpeed);
	var _lon = min(maxSpeed,point_distance_3d(0,0,0,hSpeed,vSpeed,dSpeed));
	hSpeed = +_lon*dcos(_phi)*dcos(_theta);
	vSpeed = -_lon*dsin(_phi)*dcos(_theta);
	dSpeed = -_lon*dsin(_theta);
#endregion
#region Ejecuta el movimiento.
	x += hSpeed;
	y += vSpeed;
	z += dSpeed;
	
	spdDirSpeed = tiendeAX(spdDirSpeed,point_distance_3d(0,0,0,hSpeed,vSpeed,dSpeed)/50,1*_isMoving);
	var _spd = spdDirSpeed;
	if (_spd == 0) _spd = brake/5;
	dirSpeed = angular(dirSpeed+_spd);
	
	ratLight = min(1, abs(z)/MAX_WATER_HEIGHT)*0.67;
#endregion
#region Lógica de los tentáculos.
	for (var i = 0; i < array_length(arrTentaculo); ++i)
		with(arrTentaculo[i])
			for (var j = 0; j < array_length(arrDirPhi); ++j)
			{				
				// Setea los offsets aleatorios para dar ambiente.
				if (prob(1)) arrOffsetPhi[j] = random_range(-20,20);
				if (prob(1)) arrOffsetTheta[j] = random_range(-20,20);
				
				// Los offset cambian gradualmente.
				arrOffsetPhiDraw[j] = dirTiendeAX(arrOffsetPhiDraw[j], arrOffsetPhi[j], 0.1);
				arrOffsetThetaDraw[j] = dirTiendeAX(arrOffsetThetaDraw[j], arrOffsetTheta[j], 0.1);
				
				// Movimiento fluido.				
				var _spd = (1.5*array_length(arrDirPhi)-j)/10;
				arrDirPhi[j] = dirTiendeAX(arrDirPhi[j], other.dirPhiLook + arrOffsetPhiDraw[j], _spd);
				arrDirTheta[j] = dirTiendeAX(arrDirTheta[j], other.dirThetaLook + arrOffsetThetaDraw[j], _spd);
				if (arrDirPhi[j] > 180) arrDirPhi[j] -= 360;
				if (arrDirTheta[j] > 180) arrDirTheta[j] -= 360;
			}
#endregion