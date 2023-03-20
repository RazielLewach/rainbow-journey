#region Calcula el movimiento.
	var _hTo = 0 + 1*(keyMoveRight()) - 1*(keyMoveLeft());
	var _vTo = 0 + 1*(keyMoveBack()) - 1*(keyMoveFront());
	var _dTo = 0 + 1*(keyMoveDown()) - 1*(keyMoveUp());
	if (_hTo != 0 or _vTo != 0 or _dTo != 0)
	{
		var _phi = point_direction(0,0,_hTo,_vTo)+oCamera.dirCamPhi-90;
		var _theta = point_direction(0,0,point_distance(0,0,_hTo,_vTo),_dTo);
		hSpeed += acceleration*dcos(_phi)*dcos(_theta);
		vSpeed -= acceleration*dsin(_phi)*dcos(_theta);
		dSpeed -= acceleration*dsin(_theta);
	}
#endregion
#region Ajusta la velocidad máxima.
	
#endregion
#region Tiende a frenarse y caer.
	var _phi = point_direction(0,0,hSpeed,vSpeed);
	var _theta = point_direction(0,0,point_distance(0,0,hSpeed,vSpeed),dSpeed);
	hSpeed = tiendeAX(hSpeed,0,abs(dcos(_phi)*dcos(_theta))*brake);
	vSpeed = tiendeAX(vSpeed,0,abs(dsin(_phi)*dcos(_theta))*brake);
	dSpeed = min(dSpeed+brake/5,maxSpeed);
#endregion
#region Ejecuta el movimiento.
	x += hSpeed;
	y += vSpeed;
	z += dSpeed;
#endregion