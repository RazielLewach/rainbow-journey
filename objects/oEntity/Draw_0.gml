#region Desplazamiento adicional para no atravesar muros.
	// Atrae hacia el vacuum.
	if (!oControl.isInDungeon)
	{
		xDraw = 0;
		yDraw = 0;
		zDraw = 0;
	}
	else
	{
		var _vac = getNearestVacuum(x, y, z);
		var _phi = getPhiFromCoords(x, y, _vac.x, _vac.y);
		var _theta = getThetaFromCoords(x, y, z, _vac.x, _vac.y, _vac.z);
		var _lon = radius*2*point_distance_3d(x, y, z, _vac.x, _vac.y, _vac.z)/_vac.radius;
		var _spd = maxSpeed*0.2;
		xDraw = tiendeAX(xDraw, +_lon*dcos(_phi)*dcos(_theta), _spd*abs(dcos(_phi)*dcos(_theta)));
		yDraw = tiendeAX(yDraw, -_lon*dsin(_phi)*dcos(_theta), _spd*abs(dsin(_phi)*dcos(_theta)));
		zDraw = tiendeAX(zDraw, -_lon*dsin(_theta), _spd*abs(dsin(_theta)));
	}
#endregion