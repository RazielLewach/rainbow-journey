#region Event inherited.
	event_inherited();
#endregion
#region Calcula el movimiento.
	// Calcula direcciones.
	var _hTo = 0 + 1*(keyMoveFront() and canMove) - 1*(keyMoveBack() and canMove);
	var _vTo = 0 + 1*(keyMoveRight() and canMove) - 1*(keyMoveLeft() and canMove);
	var _dTo = 0;
	isMoving = _hTo != 0 or _vTo != 0 or _dTo != 0;
	var _coords = matrix_transform_vertex(matrixBuildExt(0,0,0,0,oCamera.dirCamTheta,oCamera.dirCamPhi,1,1,1),_hTo,_vTo,_dTo);
	_hTo = _coords[0];
	_vTo = _coords[1];
	_dTo = _coords[2];
	
	if (isMoving)
	{
		var _phi = getPhiFromCoords(0,0,_hTo,_vTo);
		var _theta = getThetaFromCoords(0,0,0,_hTo,_vTo,_dTo);
		hSpeed += acceleration*dcos(_phi)*dcos(_theta);
		vSpeed -= acceleration*dsin(_phi)*dcos(_theta);
		dSpeed -= acceleration*dsin(_theta);
		
		dirPhiMoving = _phi;
		dirThetaMoving = _theta;
	}
#endregion
#region Crea luces estáticas.
	if (mouseP(mb_right))
	{
		createLight(x+xDraw, y+yDraw, z+zDraw, 200);
	}
#endregion