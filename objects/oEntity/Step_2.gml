#region ¿Te puedes mover?
	canMove = true;
#endregion
#region Mira a donde se mueve.
	var _scSpd = point_distance_3d(0,0,0,hSpeed,vSpeed,dSpeed)/maxSpeed;
	var _spdRota = acceleration*2*(0.0001 + _scSpd);
	dirPhiLook = dirTiendeAX(dirPhiLook,dirPhiMoving,_spdRota);
	dirThetaLook = dirTiendeAX(dirThetaLook,dirThetaMoving,_spdRota);
#endregion
#region Tiende a frenarse.
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
#region Ejecuta el movimiento y limita la posición.
	// Nos movemos o frenamos ante colisión.
	x += hSpeed;
	y += vSpeed;
	z += dSpeed;
	
	// Choca con el suelo, techo o bordes.
	if (!oControl.isInDungeon)
	{
		var _phi = getPhiFromCoords(ROOM_SIZE/2, ROOM_SIZE/2, x, y);
		var _lon = point_distance(ROOM_SIZE/2, ROOM_SIZE/2, x, y);
		var _maxLon = ROOM_SIZE/2-radius*1.1;
		if (_lon > _maxLon)
		{
			x = ROOM_SIZE/2 + _maxLon*dcos(_phi);
			y = ROOM_SIZE/2 - _maxLon*dsin(_phi);
		}
		z = max(-ROOM_SIZE*2+radius*1.1, min(-ROOM_SIZE-radius*1.1, z));
	}
	// Ajústate a la vacuum más cercana.
	else adjustInsideNearestVacuum(0);
#endregion
#region Colisión con entidades.
	for (var i = 0; i < instance_number(oEntity); ++i)
	{
		var _ent = instance_find(oEntity, i);
		if (_ent.id != id and point_distance_3d(x, y, z, _ent.x, _ent.y, _ent.z) < radius+_ent.radius+30)
		{
			var _phi = getPhiFromCoords(_ent.x, _ent.y, x, y);
			var _theta = getThetaFromCoords(_ent.x, _ent.y, _ent.z, x, y, z);
			var _lon = radius+_ent.radius+30;
			x = _ent.x + _lon*dcos(_phi)*dcos(_theta);
			y = _ent.y - _lon*dsin(_phi)*dcos(_theta);
			z = _ent.z - _lon*dsin(_theta);
		}
	}
#endregion