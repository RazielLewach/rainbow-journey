#region Físicas.
	z = -ROOM_SIZE - 300; // Altura.
	hSpeed = 0; // Velocidad horizontal.
	vSpeed = 0; // Velocidad vertical.
	dSpeed = 0; // Velocidad profunda.
	maxSpeed = 3; // Velocidad de movimiento.
	acceleration = 1; // Acceleración we.
	brake = 0.1; // Freno we.
	dirPhiLook = 0; // Dirección phi a la que miras.
	dirThetaLook = 0; // Dirección theta a la que miras.
	dirPhiMoving = 0; // Dirección phi a la que te mueves.
	dirThetaMoving = 0; // Dirección theta a la que te mueves.
	isMoving = false; // ¿Se está moviendo?
#endregion
#region Estado.
	iEntity = ENTITY.NOONE; // ¿Quién es?
	radius = 1; // Radio de la entidad.
	xDraw = 0; // x extra al chocar con el muro para no atravesar.
	yDraw = 0; // y extra al chocar con el muro para no atravesar.
	zDraw = 0; // z extra al chocar con el muro para no atravesar.
	depth = 10;
	canMove = true; // ¿Te puedes mover?
	isHurt = false; // ¿Está herida?
#endregion